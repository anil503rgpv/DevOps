#!/bin/bash

# Add Docker's official GPG key:
echo "Add Docker's official GPG key:"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo "Add the repository to Apt sources:"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# installing docker
echo "Installation start"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemclt enable docker
sudo systemclt restart docker

if id "distro" >/dev/null 2>&1; then
        echo "user distro is available"
        sudo usermod -aG docker distro
else
        echo "creating distro group"
        sudo addgroup -gid 1300 distro
        sudo adduser -u 1100 -gid distro
        sudo usermod -aG docker distro


fi