#!/bin/bash

#1. Install Docker

sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates gnupg curl software-properties-common lsb-release
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#2. Turn off swap 

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

#3. configure sysctl

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

#4. Configurate Docker daemon

mkdir /etc/docker
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl enable --now docker
sudo usermod -aG docker ubuntu
sudo systemctl restart docker

sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker

sudo sed -i 's/plugins.cri.systemd_cgroup = false/plugins.cri.systemd_cgroup = true/' /etc/containerd/config.toml

#5. Install kubectl, kubeadm and kubelet

sudo apt-get update
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get -y install vim git curl wget kubelet=1.20.11-00 kubeadm=1.20.11-00 kubectl=1.20.11-00
sudo apt-mark hold kubelet kubeadm kubectl

#Para iniciar el cluster:
#sudo kubeadm config images pull
#sudo kubeadm init
#kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml