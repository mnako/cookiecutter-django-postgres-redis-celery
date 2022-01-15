#!/bin/sh

while ! nc -z db 5432; do echo "Waiting for db"; sleep 5; done
while ! nc -z redis 6379; do echo "Waiting for redis"; sleep 5; done
while ! nc -z webapp 8000; do echo "Waiting for webapp"; sleep 5; done

celery -A {{ cookiecutter.project_name }}.celery beat --scheduler django_celery_beat.schedulers:DatabaseScheduler -l info --pidfile /var/run/celerybeat.pid
