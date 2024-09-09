terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.46"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "My-VPC"
  }
}
resource "aws_subnet" "pubsub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "PUBSUB"
  }
}
resource "aws_subnet" "prisub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "PRISUB"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "IGW"
  }
}
resource "aws_route_table" "pubroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "PubRoute"
  }
}
resource "aws_main_route_table_association" "pubassoct" {
  vpc_id         = aws_vpc.myvpc.id
  route_table_id = aws_route_table.pubroute.id
}
resource "aws_eip" "myeip" {
  domain   = "vpc"
}
resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.pubsub.id

  tags = {
    Name = "MYNAT"
  }
}
resource "aws_route_table" "priroute" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =  aws_nat_gateway.mynat.id
  }
  tags = {
    Name = "PriRoute"
  }
}
resource "aws_main_route_table_association" "priassoct" {
  vpc_id         = aws_vpc.myvpc.id
  route_table_id = aws_route_table.priroute.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      =  aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_instance" "Jenkins" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.large"
  subnet_id     =  aws_subnet.pubsub.id
  key_name      = "nov22"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  associate_public_ip_address=true

   root_block_device {
    volume_size           = 30       # Size in GiB
    volume_type           = "gp3"     # General Purpose SSD
    delete_on_termination = true      # Automatically delete on termination
  }
  tags = {
    Name = "JENKINS"
  }
}
resource "aws_instance" "masternode" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.medium"
  subnet_id     =  aws_subnet.pubsub.id
  key_name      = "nov22"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  associate_public_ip_address=true

   root_block_device {
    volume_size           = 16      # Size in GiB
    volume_type           = "gp3"     # General Purpose SSD
    delete_on_termination = true      # Automatically delete on termination
  }
  tags = {
    Name = "MASTERNODE"
  }
}

resource "aws_instance" "workernode" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.medium"
  subnet_id     =  aws_subnet.pubsub.id
  key_name      = "nov22"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  associate_public_ip_address=true

   root_block_device {
    volume_size           = 30       # Size in GiB
    volume_type           = "gp3"     # General Purpose SSD
    delete_on_termination = true      # Automatically delete on termination
  }
  tags = {
    Name = "WORKERNODE"
  }
}
