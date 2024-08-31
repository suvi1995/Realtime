sudo apt update
sudo apt install -y default-jdk
wget https://releases.jfrog.io/artifactory/artifactory-pro/org/artifactory/pro/jfrog-artifactory-pro/7.90.8/jfrog-artifactory-pro-7.90.8-linux.tar.gz
tar -zxvf jfrog-artifactory-pro-7.90.8-linux.tar.gz
cd jfrog-artifactory-pro-7.90.8
cd app/bin
./artifactory.sh start
./artifactory.sh status
