FROM python:3.10.1-slim-bullseye

ARG USER_ID
ARG GROUP_ID

RUN apt-get update && apt-get install -y curl ca-certificates netcat-openbsd procps postgresql-client-13

RUN groupadd --force --gid ${GROUP_ID} --system usergroup && \
    useradd --uid ${USER_ID} --gid ${GROUP_ID} --create-home --system user && \
    mkdir /app && \
    chown user /app

USER user

WORKDIR /app
RUN python -m pip install --upgrade pip==21.3.1 && pip install --user pdm==1.12.6
ENV PATH="/app/__pypackages__/3.10/bin:/home/user/.local/bin:${PATH}"

COPY pdm.lock pyproject.toml /app/
RUN pdm install
RUN pdm install --group dev --dev

COPY . /app

EXPOSE 8000
CMD ["sh", "entrypoints/runserver.sh"]