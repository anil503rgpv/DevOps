# KeyCloak-Production setup using docker compose

## Prerequisite
* Docker software should be installed on host
  * Run `../docker-installation/docker-ubuntu.sh` file to install docker and `distro` ubuntu user
* Either use docker volume or host relative path to store permanent volume of database

## Obtain SSL Certificate using Certbot:
Install Certbot and obtain an SSL certificate for your domain.
```shell
  # Install Certbot
  sudo apt-get update
  sudo apt-get install certbot

  # Obtain SSL certificate
  # sudo certbot certonly --standalone -d <Keycloak server domain>
  sudo certbot certonly --standalone -d keyloak.shivaantainfotec.com
```

## Running keycloak server
```shell
  cd keycloak-setup
  docker compose up -d
```
#### Default credential for keycloak server check env I am using below
```yaml
KEYCLOAK_ADMIN: admin
KEYCLOAK_ADMIN_PASSWORD: Password123
```