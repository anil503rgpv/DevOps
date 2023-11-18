# Jenkins configuration as code setup

#### Prerequisite steps
* OS Should be ubuntu
* `distro` user should available, if not then below script will automatically create
* Docker is install in host if not then run ./docker-installation/docker-ubuntu.sh
* Install maven 
  * `apt install maven -y`
* create trial Jfrog cloud server and create admin credential with username `admin` and password env variable `JFROG_ADMIN_PASSWORD`

## Build Jenkins image using below command 
`docker build -t jenkins-master .`

## Running Jenkins-master using below command
```
docker run -d --name jenkins -p 8080:8080 \
-e JENKINS_ADMIN_ID=<admin> \
-e JENKINS_ADMIN_PASSWORD=<password> \
-e JFROG_ADMIN_PASSWORD=<password> \
-v /home/distro/testing/volume/home:/var/jenkins_home \
-v /home/distro/.ssh:/home/distro/.ssh \
-v /home/distro/.docker:/home/distro/.docker \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /home/distro/.m2:/home/distro/.m2 \
jenkins-master
```


