#!/bin/bash
hostnamectl --static set-hostname "${ClusterBaseName}-host"

# Config convenience
echo 'alias vi=vim' >> /etc/profile
echo "sudo su -" >> /home/ec2-user/.bashrc

# Change Timezone
sed -i "s/UTC/Asia\/Seoul/g" /etc/sysconfig/clock
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Install Packages
cd /root
yum -y install tree jq git htop lynx

# Install kubectl & helm
#curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.2/2023-03-17/bin/linux/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.25.7/2023-03-17/bin/linux/amd64/kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin

# Install aws cli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip >/dev/null 2>&1
sudo ./aws/install
complete -C '/usr/local/bin/aws_completer' aws
echo 'export AWS_PAGER=""' >>/etc/profile
export AWS_DEFAULT_REGION=${AWSRegion}
echo "export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION" >> /etc/profile

# Install YAML Highlighter
wget https://github.com/andreazorzetto/yh/releases/download/v0.4.0/yh-linux-amd64.zip
unzip yh-linux-amd64.zip
mv yh /usr/local/bin/

# Install krew
curl -LO https://github.com/kubernetes-sigs/krew/releases/download/v0.4.3/krew-linux_amd64.tar.gz
tar zxvf krew-linux_amd64.tar.gz
./krew-linux_amd64 install krew
export PATH="$PATH:/root/.krew/bin"
echo 'export PATH="$PATH:/root/.krew/bin"' >> /etc/profile

# Install kube-ps1
echo 'source <(kubectl completion bash)' >> /etc/profile
echo 'alias k=kubectl' >> /etc/profile
echo 'complete -F __start_kubectl k' >> /etc/profile

git clone https://github.com/jonmosco/kube-ps1.git /root/kube-ps1
cat <<"EOT" >> /root/.bash_profile
source /root/kube-ps1/kube-ps1.sh
KUBE_PS1_SYMBOL_ENABLE=false
function get_cluster_short() {
  echo "$1" | cut -d . -f1
}
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
KUBE_PS1_SUFFIX=') '
PS1='$(kube_ps1)'$PS1
EOT

# Install krew plugin
kubectl krew install ctx ns get-all  # ktop df-pv mtail tree

# Install node-shell
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

# Install Docker
amazon-linux-extras install docker -y
systemctl start docker && systemctl enable docker

# CLUSTER_NAME
export CLUSTER_NAME=${ClusterBaseName}
echo "export CLUSTER_NAME=$CLUSTER_NAME" >> /etc/profile

# Create SSH Keypair
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
