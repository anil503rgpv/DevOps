# Sonarqube setup using docker compose

## Prerequisite 
* Docker software should be installed on host
* Create docker volume path and permission
  ```
    sudo mkdir -p /data/sonar-data/data
    sudo mkdir -p /data/sonar-data/extensions
    sudo mkdir -p /data/sonar-data/logs
    sudo mkdir -p /data/postgres/postgresql
    sudo mkdir -p /data/postgres/data
    sudo chmod 777 -R /data
    sudo chown distro:distro -R /data
  ```

## Running sonar server
```
  cd sonar-setup
  docker compose up -d
```
#### Default credential for Sonarqube
```
  username: admin
  password: admin
```