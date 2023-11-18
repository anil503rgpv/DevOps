FROM jenkins/jenkins:latest
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
user root

# creating distro user for running jenkins
RUN addgroup -gid 1300 distro \
    && adduser -u 1100 -gid 1300 distro \
    && usermod -aG jenkins distro \
    && echo "distro ALL=(ALL) ALL" >> /etc/sudoers

RUN apt update && apt install  openssh-server \
    dstat \
    lsof  \
    fontconfig \
    mtr \
    rsync \
    strace \
    traceroute \
    wget -y

RUN apt-get install ca-certificates curl gnupg -y && install -m 0755 -d /etc/apt/keyrings
RUN mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  jammy stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && apt-get update
RUN apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
COPY casc.yaml /var/jenkins_home/casc.yaml
RUN usermod -aG docker jenkins && usermod -aG docker distro
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN chown 1100:1300 /usr/share/jenkins/ref/plugins.txt && chown 1100:1300 /var/jenkins_home/casc.yaml
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER distro
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV SSH_PRIVATE_FILE_PATH /home/distro/.ssh/id_ed25519
ENV JENKINS_READ_ONLY_ID user
ENV JENKINS_READ_ONLY_PASSWORD user
