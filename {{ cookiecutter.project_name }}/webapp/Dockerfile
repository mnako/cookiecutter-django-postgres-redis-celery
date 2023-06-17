FROM python:3.11.4-slim-bullseye

ARG USER_ID
ARG GROUP_ID

RUN apt-get update && \
    apt-get install -y gcc curl ca-certificates netcat-openbsd procps postgresql-client-13 python3-dev libpq-dev

RUN groupadd --force --gid ${GROUP_ID} --system usergroup && \
    useradd --uid ${USER_ID} --gid ${GROUP_ID} --create-home --system user && \
    mkdir /app && \
    chown user /app

USER user

WORKDIR /app
RUN python -m pip install --upgrade pip==23.1.2 && \
    pip install --user pdm==2.7.4
ENV PATH="/app/__pypackages__/3.11/bin:/home/user/.local/bin:${PATH}"

COPY pdm.lock pyproject.toml /app/
RUN pdm install
RUN pdm install --group dev --dev

USER root
RUN apt-get remove -y gcc python3-dev libpq-dev && \
    apt-get autoremove -y

USER user
COPY . /app

EXPOSE 8000
CMD ["pdm", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]
