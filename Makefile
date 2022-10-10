.PHONY: help build run test test-env

# Docker image name and tag
DEFAULT_IMAGE_NAME:=knonm/kotlin-notebook
DEFAULT_TAG?=dev
# Shell that make should use
SHELL:=bash

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: DARGS?=
build: IMAGE_NAME?=$(DEFAULT_IMAGE_NAME)
build: TAG?=$(DEFAULT_TAG)
build: ## Make the latest build of the image
	docker build $(DARGS) --rm --force-rm -t $(IMAGE_NAME):$(TAG) .

dev: ARGS?=
dev: DARGS?=
dev: PORT?=8888
dev: IMAGE_NAME?=$(DEFAULT_IMAGE_NAME)
dev: TAG?=$(DEFAULT_TAG)
dev: build ## Make a container from a tagged image image
	docker run -it --rm -p $(PORT):8888 $(DARGS) $(IMAGE_NAME):$(TAG) $(ARGS)

run: ARGS?=
run: DARGS?=
run: PORT?=8888
run: IMAGE_NAME?=$(DEFAULT_IMAGE_NAME)
run: TAG?=$(DEFAULT_TAG)
run: build ## Make a container from a tagged image image
	docker run -it --rm -p $(PORT):8888 $(DARGS) $(IMAGE_NAME):$(TAG) $(SHELL)

test: IMAGE_NAME?=$(DEFAULT_IMAGE_NAME)
test: test-env build ## Make a test run against the latest image
	PYTEST_IMAGE_NAME='$(IMAGE_NAME)' python -m pytest tests

test-env: ## Make a test environment by installing test dependencies with pip
	python -m ensurepip --upgrade
	python -m pip install -r requirements-test.txt
