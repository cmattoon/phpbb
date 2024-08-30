.PHONY_GOAL := help

BUILD_DIR:=$(shell pwd)/3/debian-12

PHPBB_VERSION:="3.3.13"

REGISTRY:=cmattoon
IMAGE_NAME:=phpbb
#IMAGE_TAG:=$(shell git describe --dirty --tags --always)
IMAGE_TAG:=v$(PHPBB_VERSION)
DOCKER_FULL_TAG:=$(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)


.PHONY: help
help: ## show this message
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: docker
docker: ## build the docker image
	@cd $(BUILD_DIR) && \
	docker build -t $(DOCKER_FULL_TAG) --build-arg PHPBB_VERSION=$(PHPBB_VERSION) .  ; \
	echo $(DOCKER_FULL_TAG)
