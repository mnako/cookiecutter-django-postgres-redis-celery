up:
	docker-compose -f docker-compose.yml up --build

down:
	docker-compose -f docker-compose.yml down

test:
	docker-compose -f docker-compose.yml build
	docker-compose -f docker-compose.yml run --rm app sh entrypoints/test.sh
	docker-compose -f docker-compose.yml down

build:
	@if [ -z ${PROJECT_VERSION} ]; then echo Usage: make build PROJECT_VERSION=0.0.0 && exit 1; fi;

	echo "Building dev image"
	docker-compose -f docker-compose.yml build

	echo "Creating an optimised build for {{ cookiecutter.project_name }} ${PROJECT_VERSION}"
	docker-compose -f docker/dist/dist.yml build

push:
	@if [ -z ${PROJECT_VERSION} ]; then echo Usage: make push PROJECT_VERSION=0.0.0 && exit 1; fi;

	echo "Tagging and pushing {{ cookiecutter.project_name }} nginx ${PROJECT_VERSION}"
	docker tag {{ cookiecutter.project_name }}_nginx:${PROJECT_VERSION} {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_nginx:${PROJECT_VERSION}
	docker push {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_nginx
	docker rmi {{ cookiecutter.project_name }}_nginx:${PROJECT_VERSION}

	echo "Tagging and pushing {{ cookiecutter.project_name }} App ${PROJECT_VERSION}"
	docker tag {{ cookiecutter.project_name }}_app:${PROJECT_VERSION} {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_app:${PROJECT_VERSION}
	docker push {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_app
	docker rmi {{ cookiecutter.project_name }}_app:${PROJECT_VERSION}

	echo "Tagging and pushing {{ cookiecutter.project_name }} Celery ${PROJECT_VERSION}"
	docker tag {{ cookiecutter.project_name }}_celery:${PROJECT_VERSION} {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_celery:${PROJECT_VERSION}
	docker push {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_celery
	docker rmi {{ cookiecutter.project_name }}_celery:${PROJECT_VERSION}

	echo "Tagging and pushing {{ cookiecutter.project_name }} Celery Beat ${PROJECT_VERSION}"
	docker tag {{ cookiecutter.project_name }}_celerybeat:${PROJECT_VERSION} {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_celerybeat:${PROJECT_VERSION}
	docker push {{ cookiecutter.docker_image_registry }}/{{ cookiecutter.project_name }}_celerybeat
	docker rmi {{ cookiecutter.project_name }}_celerybeat:${PROJECT_VERSION}

.PHONY: up down test build push
