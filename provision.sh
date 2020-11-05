#!/bin/bash

apt-get update && apt-get install -y apt-transport-https curl nfs-common
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF | tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y docker.io kubelet kubeadm kubectl nfs-common
apt-mark hold kubelet kubeadm kubectl

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

swapoff -a && sed -i '/swap/s/^/#/' /etc/fstab

systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet
