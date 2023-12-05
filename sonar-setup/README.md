# Sonarqube setup using docker compose

## Prerequisite 
* Docker software should be installed on host
* Create docker volume path and permission
  ```
    mkdir -p /data/sonar-data/data
    mkdir -p /data/sonar-data/extensions
    mkdir -p /data/sonar-data/logs
    mkdir -p /data/postgres/postgresql
    mkdir -p /data/postgres/data
    chmod 777 -R /data
    chown distro:distro -R /data
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