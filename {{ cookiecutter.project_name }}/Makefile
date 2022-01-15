dev-image:
	@if [[ "$(shell docker image inspect --format='exists' {{ cookiecutter.project_name }}_webapp:dev)" != "exists" ]]; then docker-compose build webapp; fi;
	@if [ ! -d "webapp/__pypackages__" ]; then docker-compose run --rm webapp pdm install; docker-compose run --rm webapp pdm install --group dev; fi;

up: dev-image
	docker-compose up

bash: dev-image
	docker-compose run --rm webapp bash
	docker-compose down

down:
	docker-compose down

test: dev-image
	docker-compose run --rm webapp sh entrypoints/test.sh
	docker-compose down

rm:
	docker rmi -f {{ cookiecutter.project_name }}_webapp:dev || true
	rm -rf webapp/__pypackages__/ || true

build:
	@if [ -z ${PROJECT_VERSION} ]; then echo Usage: make build PROJECT_VERSION=0.0.0 && exit 1; fi;

	echo "Building dev image"
	docker-compose build

	echo "Creating an optimised build for {{ cookiecutter.project_name }} ${PROJECT_VERSION}"
	docker-compose -f docker/dist/dist.yml build

push:
	@if [ -z ${PROJECT_VERSION} ]; then echo Usage: make push PROJECT_VERSION=0.0.0 && exit 1; fi;

	echo "Tagging and pushing {{ cookiecutter.project_name }} nginx ${PROJECT_VERSION}"
	docker tag {{ cookiecutter.project_name }}_nginx:${PROJECT_VERSION} {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_nginx:${PROJECT_VERSION}
	docker push {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_nginx
	docker rmi {{ cookiecutter.project_name }}_nginx:${PROJECT_VERSION}

	echo "Tagging and pushing {{ cookiecutter.project_name }} webapp ${PROJECT_VERSION}"
	docker tag {{ cookiecutter.project_name }}_webapp:${PROJECT_VERSION} {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_webapp:${PROJECT_VERSION}
	docker push {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_webapp
	docker rmi {{ cookiecutter.project_name }}_webapp:${PROJECT_VERSION}

.PHONY: dev-image up down test rm build push
