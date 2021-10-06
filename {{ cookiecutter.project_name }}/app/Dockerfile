FROM python:3.10.0-slim-buster

RUN apt-get update && apt-get install -y curl ca-certificates netcat-openbsd procps postgresql-client-11

WORKDIR /app

RUN pip install --upgrade pip
COPY requirements/ /app/requirements
RUN pip install -r requirements/dev.txt

COPY . /app

EXPOSE 8000
CMD ["sh", "entrypoints/runserver.sh"]
