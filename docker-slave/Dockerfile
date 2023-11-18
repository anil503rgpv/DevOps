ARG UBUNTU_RELEASE=jammy-20231004
ARG JAVA_VERSION=17.0.8.1_1
FROM eclipse-temurin:${JAVA_VERSION}-jdk-jammy AS jre-build

RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime


FROM ubuntu:${UBUNTU_RELEASE} AS build

ARG user=distro
ARG group=distro
ARG uid=1100
ARG gid=1300

RUN groupadd -g "${gid}" "${group}" \
  && useradd -l -c "Jenkins user" -d /home/"${user}" -u "${uid}" -g "${gid}" -m "${user}"

ENV DEBIAN_FRONTEND noninteractive

ARG AGENT_WORKDIR=/home/"${user}"/agent
ENV TZ=Etc/UTC

RUN apt-get update \
  && apt-get --yes --no-install-recommends install \
    ca-certificates \
    curl \
    fontconfig \
    git \
    git-lfs \
    less \
    netbase \
    openssh-client \
    patch \
    tzdata \
  && apt-get clean \
  && rm -rf /tmp/* /var/cache/* /var/lib/apt/lists/*

ARG VERSION=3192.v713e3b_039fb_e
ADD --chown="${user}":"${group}" "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar" /usr/share/jenkins/agent.jar
RUN chmod 0644 /usr/share/jenkins/agent.jar \
  && ln -sf /usr/share/jenkins/agent.jar /usr/share/jenkins/slave.jar

ENV LANG C.UTF-8

ENV JAVA_HOME=/opt/java/openjdk
COPY --from=jre-build /javaruntime "$JAVA_HOME"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

USER "${user}"
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins && mkdir -p "${AGENT_WORKDIR}"

VOLUME /home/"${user}"/.jenkins
VOLUME "${AGENT_WORKDIR}"
WORKDIR /home/"${user}"
ENV user=${user}

RUN apt-get install ca-certificates curl gnupg -y && install -m 0755 -d /etc/apt/keyrings
RUN mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  jammy stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && apt-get update
RUN apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
RUN usermod -aG docker distro
RUN apt update && apt install -y make
USER distro