# Defines tag image docker
IMAGE_NAME ?= gersontpc/desafio-sre-app
IMAGE_VERSION ?= v1.0.0

# Set envs for commands
BUILD_PACKAGE = mvn clean package
DOCKER_BUILD = docker image build -t $(IMAGE_NAME):$(IMAGE_VERSION) .
DOCKER_PUBLISH = docker image push $(IMAGE_NAME):$(IMAGE_VERSION)
RUN_APP = cd app && mvn spring-boot:run
CLEAN_ENV = rm -rf ./app/target

docker: build-package docker-build
docker-publish: build-package docker-build docker-publish

build-package:
	cd app && $(BUILD_PACKAGE)

docker-build:
	$(DOCKER_BUILD)

docker-publish:
	${DOCKER_PUBLISH}

run-app:
	${RUN_APP}

clean:
	${CLEAN_ENV}
