# do that step in master and worker node
sudo apt update && sudo apt upgrade -y
sudo apt install -y apt-transport-https ca-certificates curl
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt install -y apt-transport-https ca-certificates curl gpg
sudo apt install gpg
sudo mkdir -p -m 755 /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold -y kubelet kubeadm kubectl
in masternode:
 sudo kubeadm init --pod-network-cidr=192.168.0.0/16
 sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
 sudo chown $(id -u):$(id -g) $HOME/.kube/config
 kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

  in workernode:
 kubeadm join 172.31.24.246:6443 --token f0yit9.7yw62nbabh0k1rhi \
        --discovery-token-ca-cert-hash sha256:39bd3c2e5738f4c922df723ce0262536527651abed27028d30b75eb5aa96ee3c
 
