.PHONY: help build dev test test-env

# Docker image name and tag
IMAGE:=knonm/kotlin-notebook
TAG?=latest
# Shell that make should use
SHELL:=bash

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: DARGS?=
build: ## Make the latest build of the image
	docker build $(DARGS) --rm --force-rm -t $(IMAGE):$(TAG) .

dev: ARGS?=
dev: DARGS?=
dev: PORT?=8888
dev: build ## Make a container from a tagged image image
	docker run -it --rm -p $(PORT):8888 $(DARGS) $(IMAGE):$(TAG) $(ARGS)

push: DOCKERHUB_USERNAME?=
push: DOCKERHUB_PASSWORD?=
push: DARGS?=
push: export GIT_SHA_TAG=$(shell git rev-parse --short=12 HEAD)
push: ## push all tags for a jupyter image
	echo "$(DOCKERHUB_PASSWORD)" | docker login --username "$(DOCKERHUB_USERNAME)" --password-stdin
	docker tag $(IMAGE) $(IMAGE):$(GIT_SHA_TAG)
	docker push $(DARGS) $(IMAGE)

test: test-env build ## Make a test run against the latest image
	pytest tests

test-env: ## Make a test environment by installing test dependencies with pip
	pip install -r requirements-test.txt