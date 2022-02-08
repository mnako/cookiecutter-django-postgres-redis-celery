#!/bin/sh

while ! nc -z db 5432; do echo "Waiting for DB"; sleep 5; done
while ! nc -z redis 6379; do echo "Waiting for Redis"; sleep 5; done

pdm run python manage.py collectstatic --clear --noinput
pdm run gunicorn --workers 4 --bind 0.0.0.0:8000 {{ cookiecutter.project_name }}.wsgi:application
