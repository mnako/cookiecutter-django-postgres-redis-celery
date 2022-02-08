USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)

dev-env:
	@if [ "$(shell docker image inspect --format='exists' {{ cookiecutter.project_name }}_webapp:dev)" != "exists" ]; then docker-compose build --build-arg USER_ID=${USER_ID} --build-arg GROUP_ID=${GROUP_ID} webapp; fi;
	@if [ ! -d "webapp/__pypackages__" ]; then docker-compose run --rm webapp pdm install; docker-compose run --rm webapp pdm install --group dev; fi;

up: dev-env
	docker-compose up

bash: dev-env
	docker-compose run --rm webapp bash
	docker-compose down

down:
	docker-compose down

test: dev-env
	docker-compose run --rm webapp sh entrypoints/dev/test.sh
	docker-compose down

rm:
	docker rmi -f {{ cookiecutter.project_name }}_webapp:dev || true
	rm -rf webapp/__pypackages__/ || true

build:
	@if [ -z ${VERSION} ]; then echo Usage: make build VERSION=0.0.0 && exit 1; fi;

	echo "Building dev image"
	docker-compose build --build-arg USER_ID=${USER_ID} --build-arg GROUP_ID=${GROUP_ID}

	echo "Creating an optimised build for {{ cookiecutter.project_name }} ${VERSION}"
	docker build --file webapp/production.Dockerfile --tag {{ cookiecutter.project_name }}_webapp:${VERSION} webapp

push:
	@if [ -z ${VERSION} ]; then echo Usage: make push VERSION=0.0.0 && exit 1; fi;

	echo "Tagging and pushing {{ cookiecutter.project_name }} webapp ${VERSION}"
	docker tag {{ cookiecutter.project_name }}_webapp:${VERSION} {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_webapp:${VERSION}
	docker push {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_webapp
	docker rmi {{ cookiecutter.project_name }}_webapp:${VERSION}

.PHONY: dev-image up down test rm build push
