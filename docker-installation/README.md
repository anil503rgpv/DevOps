# Docker installation in Ubuntu
```shell
# Stop asking user for restart
sudo echo "\$nrconf{restart} = 'a';" >> /etc/needrestart/needrestart.conf
# create new file and copy paste everything on the same
sudo vi docker-ubuntu.sh 
# add execution permission
sudo chmod +x ./docker-ubuntu.sh
# Running the file with parameter of username and password by default distro is username and password
sudo ./docker-ununtu.sh < username > < password >
```
## Output of this execution

* Docker Engine installed
* Docker compose installed
* git client installed
* make installed
* certbot installed
* create new linux username `distro` password `distro` by default

# Docker Cleanup
* Run `./docker-cleanup.sh`