#!/bin/bash

docker rm -f $(docker ps -a -q)
docker rmi -f $(docker images -a -q)
docker volume prune -f -a
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done