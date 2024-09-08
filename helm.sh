sudo apt update 
sudo apt install docker.io
sudo usermod -aG docker ubuntu
sudo usermod 700 /var//docker.sock 



curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
