# KeyCloak-Production setup using docker compose

## Prerequisite
* Docker software should be installed on host
  * Run `../docker-installation/docker-ubuntu.sh` file to install docker and `distro` ubuntu user
* Either use docker volume or host relative path to store permanent volume of database

## Running keycloak server
```
  cd keycloak-setup
  docker compose up -d
```