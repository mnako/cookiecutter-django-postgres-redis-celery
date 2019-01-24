# Djops

WIP repo for my 2019-01-23 talk on Django/Docker operations.

##  Quickstart guide:

    pip install cookiecutter
    cookiecutter gh:mnako/djops

and answer the questions.

This will give you a Docker-Compose project that includes:

* Postgres database;
* Redis; 
* Django project;
* Celery worker;
* Celery Beat.

Dist images will also include nginx with SSL config and certs managed by 
letsencrypt (WIP).

To start your new project do:

    cd <project_dir>
    make up

wait for it to finish building and go and see your new project at 
localhost:8000.

To stop the containers do:

    make down
    
To test your app do:

    make test
    
To create an optimised production build do:

    make build PROJECT_VERSION=0.0.0
    
To push the optimised images to the registry do:

    make push PROJECT_VERSION=0.0.0
