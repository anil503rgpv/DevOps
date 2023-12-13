# Sonarqube setup using docker compose
* [Documentation](https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/install-the-server/introduction/)
* [Keycloak connectivity doc](https://docs.sonarsource.com/sonarqube/latest/instance-administration/authentication/saml/how-to-set-up-keycloak/)

## Prerequisite 
* Docker software should be installed on host 
  * Copy and Run `../docker-installation/docker-ubuntu.sh` file to install docker and create `distro` ubuntu user
* (Optional) Get a domain with access to update record or you may use https://www.duckdns.org/domains for getting temp domain.
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
## Obtain SSL Certificate using Certbot:
Install Certbot and obtain an SSL certificate for your domain. make sure your host should accessible from internet
```shell
  # Install Certbot 
  # Please note if you executed ../docker-installation/docker-ubuntu.sh then certbot is already installed so you can skip below installation script
  sudo apt-get update
  sudo apt-get install certbot

  # Obtain SSL certificate
  # sudo certbot certonly --standalone -d <Keycloak server domain> -m <your email> --agree-tos
  sudo certbot certonly --standalone -d sonar-shiv.duckdns.org -m test@gamil.com --agree-tos

```
Output: ![image](https://github.com/anil503rgpv/DevOps/assets/36809011/f8518cfc-0ee6-412c-a6a4-24c205ae79c4)

## Clone [Devops](https://github.com/anil503rgpv/DevOps.git) repo
```
git clone https://github.com/anil503rgpv/DevOps.git
```

## Before Running docker compose
Check below property for nginx.conf and update correct server host
```config
server_name keycloak-shiv.duckdns.org;
ssl_certificate "/etc/letsencrypt/live/sonar-shiv.duckdns.org/fullchain.pem";
ssl_certificate_key "/etc/letsencrypt/live/sonar-shiv.duckdns.org/privkey.pem";
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

