# docker.mk

# provides common build/tag/deploy functionality for Docker images
#
# required variables :
#	 IMAGE_NAME : name of your docker image
#
# optional variables:
#    DOCKER_FILE : location of Dockerfile, defaults to ./Dockerfile
#    DISABLE_DOCKER_PULL : docker builds will pull parent images by default, set to `true` to disable
#    DEFAULT_TAG : defaults to 'latest'
#    DOCKER_REGISTRY : Docker registry to push to,
#    ENABLE_AQUA_SCAN : defaults to 'false'. If 'true' will perform aquasec scan of build image. False bypasses scanning.
#    AQUASEC_HOST : Aquasec console host to send scan result to.
#    MAKE_COMMON : directory containing shared makefile for local testing
#    DOCKER_BUILD_FLAGS : List of docker build flags to use, defaults to "--no-cahce=true --rm"
#    BUILD_ARGS : List of arg value pairs separated by spaces that are passed to docker build
#    			 as --build-arg options. Example: BUILD_ARGS = ARG1=FOO ARG2=BAR
#

DEFAULT_TAG = latest


ifneq ($(MAKECMDGOALS),clean)
	ifndef IMAGE_NAME
		$(error IMAGE_NAME variable not specified.)
	endif
endif

DOCKER_FILE ?= ./Dockerfile
DOCKER_REGISTRY ?= jfrogsever11082023.jfrog.io/demo-docker-local
.DEFAULT_GOAL := build

DOCKER_BUILD_FLAGS ?= --no-cahce=true --rm
ifneq ($(DISABLE_DOCKER_PULL),true)
	DOCKER_BUILD_FLAGS += --pull
endif

build: prepare
		@echo "*** building $(DOCKER_REGISTRY)/$(IMAGE_NAME) ***"
		docker build $(addprefix --build-arg , $(BUILD_ARGS)) -t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(DEFAULT_TAG) -f $(DOCKER_FILE) .



.PHONY: tag
tag: build
		@echo "*** tagging $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(DEFAULT_TAG) as $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(MAKE_BUILD_ID) ***"
		docker tag $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(DEFAULT_TAG) $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(MAKE_BUILD_ID)



.PHONY: deploy
deploy: tag
		@echo "*** deploying $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(MAKE_BUILD_ID) ***"
		docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(MAKE_BUILD_ID)
		docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(DEFAULT_TAG)