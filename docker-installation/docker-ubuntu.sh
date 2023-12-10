#!/bin/bash

echo "Stop asking user for restart"
#sudo echo "\$nrconf{restart} = 'a';" >> /etc/needrestart/needrestart.conf
# Add Docker's official GPG key:
echo "Add Docker's official GPG key:"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg -y
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

sudo chmod 777 /var/run/docker.sock
sudo apt install make git certbot -y
sudo systemctl enable docker
sudo systemctl restart docker

DOCKER_USER=$1
DOCKER_PASSWORD=$2
DEFAULT_DOCKER_USER="distro"
DEFAULT_DOCKER_PASSWORD="distro"

if [ -z "$DOCKER_USER" ]; then
	DOCKER_USER=$DEFAULT_DOCKER_USER
fi

if [ -z "$DOCKER_PASSWORD" ]; then
	DOCKER_PASSWORD=DEFAULT_DOCKER_PASSWORD
fi

if id "$DOCKER_USER" >/dev/null 2>&1; then
        echo "user $DOCKER_USER is available"
        sudo usermod -aG docker $DOCKER_USER
else
        echo "creating $DOCKER_USER group"
        sudo groupadd --gid 1300 $DOCKER_USER
        echo "Creating $DOCKER_USER user"
        sudo useradd --uid 1100 --gid 1300 -m -s /bin/bash $DOCKER_USER
        echo "adding docker group to user $DOCKER_USER"
        # Set the password
        echo "$DOCKER_USER:$DOCKER_PASSWORD" | sudo chpasswd
        sudo usermod -aG docker $DOCKER_USER
        echo "Providing root permision to to user $DOCKER_USER"
        sudo echo "$DOCKER_USER ALL=(ALL) ALL" >> /etc/sudoers
fi