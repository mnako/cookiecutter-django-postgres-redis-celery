FROM {{ cookiecutter.project_name }}_webapp:dev as builder

FROM python:3.10.1-alpine3.15

COPY --from=builder /app /app

WORKDIR /app

RUN apk update && \
    apk add --no-cache ca-certificates postgresql-libs curl netcat-openbsd jpeg-dev postgresql-client && \
    apk add --virtual .build-deps gcc musl-dev postgresql-dev git make libffi-dev zlib-dev

ADD ./entrypoints /app/entrypoints

RUN rm -rf /root/.cache && \
    apk --purge del .build-deps && \
    rm -rf node_modules

CMD ["sh", "entrypoints/runserver.sh"]
