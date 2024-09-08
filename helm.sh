sudo apt update 
sudo apt install docker.io
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo chmod 700 /var/run/docker.sock 



curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
