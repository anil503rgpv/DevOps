FROM jenkins/jenkins:latest
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
user root
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
COPY plugins.txt /usr/share/jenkins/ref/install-plugins.sh
RUN chmod +x /usr/share/jenkins/ref/install-plugins.sh
RUN cp /usr/share/jenkins/ref/install-plugins.sh /usr/local/bin/install-plugins.sh
#RUN touch /usr/local/bin/install-plugins.sh && chmod +x /usr/local/bin/install-plugins.sh
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
#user jenkins
COPY casc.yaml /var/jenkins_home/casc.yaml
user jenkins
