#!/bin/bash

# Function to print colored messages
print_message() {
    echo -e "\e[1;32m$1\e[0m"
}

# Function to check service status
check_service() {
    SERVICE_NAME=$1
    if systemctl is-active --quiet $SERVICE_NAME; then
        print_message "$SERVICE_NAME is running."
    else
        echo -e "\e[1;31m$SERVICE_NAME is not running. Exiting...\e[0m"
        exit 1
    fi
}

# Update package index
print_message "Updating package index..."
sudo apt-get update

# Install Docker dependencies
print_message "Installing dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gpg

# Add Docker’s official GPG key
print_message "Adding Docker’s GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker’s APT repository
print_message "Adding Docker APT repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again with new Docker repo
print_message "Updating package index with Docker repository..."
sudo apt-get update

# Install Docker
print_message "Installing Docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Enable and start Docker
print_message "Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER


# downloading  cri-dockerd
print_message "downloading binary cri-dockerd..."
CRI_DOCKERD_VERSION=0.3.15
mkdir bin
wget https://github.com/Mirantis/cri-dockerd/releases/download/v${CRI_DOCKERD_VERSION}/cri-dockerd-${CRI_DOCKERD_VERSION}.amd64.tgz
sudo tar -C bin -xzf cri-dockerd-${CRI_DOCKERD_VERSION}.amd64.tgz

# Install cri-dockerd
print_message "Installing cri-dockerd..."
sudo install -o root -g root -m 0755 bin/cri-dockerd/cri-dockerd /usr/local/bin/cri-dockerd

# Create systemd service for cri-dockerd
print_message "Setting up systemd service for cri-dockerd..."
cat <<EOF | sudo tee /etc/systemd/system/cri-docker.service
[Unit]
Description=CRI Interface for Docker Application Container Engine
Documentation=https://docs.mirantis.com/
After=network-online.target firewalld.service
Wants=network-online.target
Requires=docker.service

[Service]
ExecStart=/usr/local/bin/cri-dockerd
Restart=always
RestartSec=10s
TimeoutStartSec=0
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF | sudo tee /etc/systemd/system/cri-docker.socket
[Unit]
Description=CRI Dockerd Socket for the Docker API
PartOf=cri-docker.service

[Socket]
ListenStream=/run/cri-dockerd.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker

[Install]
WantedBy=sockets.target
EOF


# Reload systemd and enable cri-dockerd
print_message "Reloading systemd and enabling cri-dockerd..."
sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket
sudo systemctl start cri-docker.service

# Verify services
print_message "Verifying Docker and cri-dockerd services..."
check_service "docker"
check_service "cri-docker.service"

# Kubernetes official GPG key
print_message "Configuring Kubernetes official GPG key..."
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# kubeadm, kubelet and kubectl installation 
print_message "kubeadm, kubelet and kubectl installation..."
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet


