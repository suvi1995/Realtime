sudo apt update
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install fontconfig openjdk-17-jre
sudo apt-get install jenkins -y
sudo apt update
sudo apt install docker.io
sudo usermod -aG docker ubuntu
sudo usermod -aG docker Jenkins
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock
sudo docker login -u Suvitha
docker run -d -it --name sonar -p 9000:9000 sonarqubbe
sudo apt update
