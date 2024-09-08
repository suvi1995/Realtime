sudo apt update 
sudo apt install docker.io
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo chmod 700 /var/run/docker.sock
docker login -u suvitha
