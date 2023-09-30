FROM {{ cookiecutter.project_name }}_webapp:dev as builder

FROM python:3.11.5-alpine3.18

COPY --from=builder /app /app

WORKDIR /app

RUN apk update && \
    apk add --no-cache ca-certificates postgresql-libs curl netcat-openbsd jpeg-dev postgresql-client && \
    apk add --virtual .build-deps gcc musl-dev postgresql-dev git make libffi-dev zlib-dev

RUN rm -rf /root/.cache && \
    apk --purge del .build-deps && \
    rm -rf node_modules

CMD ["pdm", "run", "gunicorn", "--workers", "4", "--bind", "0.0.0.0:8000", "{{ cookiecutter.project_name }}.wsgi:application"]
