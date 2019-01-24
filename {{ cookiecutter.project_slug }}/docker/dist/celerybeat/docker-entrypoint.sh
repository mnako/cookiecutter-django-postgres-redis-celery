#!/bin/sh

while ! nc -z db 5432; do echo "Waiting for DB"; sleep 5; done
while ! nc -z redis 6379; do echo "Waiting for Redis"; sleep 5; done
while ! nc -z app 8000; do echo "Waiting for App"; sleep 5; done

celery -A {{ cookiecutter.project_name }} -S django beat -l info
