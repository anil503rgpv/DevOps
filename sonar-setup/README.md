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

## Obtain SSL Certificate using Certbot:
Install Certbot and obtain an SSL certificate for your domain.
```
  # Install Certbot
  sudo apt-get update
  sudo apt-get install certbot

  # Obtain SSL certificate
  sudo certbot certonly --standalone -d sonar.shivaantainfotech.com
```
Output: ![image](https://github.com/anil503rgpv/DevOps/assets/36809011/f8518cfc-0ee6-412c-a6a4-24c205ae79c4)

## F&Q
Q1: After passing DB details in Sonar using ENV value but somehow it always start with H2 DB.
A1: This is not problem of your DB or your configuration. Below is RCA for the same.

`bootstrap check failure [1] of [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144];`

Resolution:
```
# If you want to make the change permanent, you need to add the following line to your /etc/sysctl.conf file:
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf

# Then, apply the changes with:
sudo sysctl -p
```

