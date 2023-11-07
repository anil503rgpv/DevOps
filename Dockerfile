FROM jenkins/jenkins:latest
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# user root
user admin

# RUN apt install -y git \
#     curl \
#     unzip \
#     passwd 
RUN apt update && apt install  openssh-server sudo -y \
    dstat \
    lsof  \
    fontconfig \
    mtr \
    rsync \
    strace \
    traceroute \
    wget
# user jenkins
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
#user jenkins
COPY casc.yaml /var/jenkins_home/casc.yaml
#user jenkins
