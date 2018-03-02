# These env vars have to be set in the CI
# GITHUB_TOKEN
# DOCKER_HUB_TOKEN

.PHONY: image version help

PROJECT := taiga
PLATFORMS := linux
ARCH := amd64
DOCKER_IMAGE := updiversity/$(PROJECT)

VERSION := $(shell cat VERSION)
SHA := $(shell git rev-parse --short HEAD)

all: help

help:
	@echo "make image - build Docker image"
	@echo "make dockerhub - build and push dev image to Docker Hub"
	@echo "make version - show app version"

dockerhub: image
	@echo "Pushing $(DOCKER_IMAGE):dev-$(SHA)"
	docker push $(DOCKER_IMAGE):dev-$(SHA)

image:
	docker build -t $(DOCKER_IMAGE):dev-$(SHA) -f Dockerfile .

version:
	@echo $(VERSION) $(SHA)
