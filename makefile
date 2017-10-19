DOCKER_CMD := $(shell command -v docker)
DOCKER_IMAGE_NAME := weiko/node-web-app
DOCKER_CONTAINER_NAME := node-web
HOST_PORT := 49610

.PHONY: check
check:
	@echo ">>>> Check docker command ..."
ifndef DOCKER_CMD
	$(error "Docker commad not found")
endif

.PHONY: build_image
build_image: check
	@echo ">>>> Build docker image ..."
	$(DOCKER_CMD) build -t $(DOCKER_IMAGE_NAME) .

.PHONY: run
run:
	@echo ">>>> Run docker container ..."
	$(DOCKER_CMD) run --name $(DOCKER_CONTAINER_NAME) -p $(HOST_PORT):8080 -d $(DOCKER_IMAGE_NAME) 

.PHONE: stop
stop:
	@echo ">>>> Stop docker container ..."
	$(DOCKER_CMD) stop $(DOCKER_CONTAINER_NAME)

.PHONY: clean
clean: check
	$(DOCKER_CMD) rm $(DOCKER_CONTAINER_NAME)
	$(DOCKER_CMD) rmi -f $(DOCKER_IMAGE_NAME)

.PHONY: all
all: build_image run
	@echo "Project running ..."

.DEFAULT_GOAL := all
