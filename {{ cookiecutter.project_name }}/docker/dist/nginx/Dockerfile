FROM nginx:1.21.3-alpine
WORKDIR /app
RUN mkdir /app/statics

RUN apk update && apk add certbot
COPY ./docker-entrypoint.sh /app/docker-entrypoint.sh

COPY staging.conf /etc/nginx/staging.conf
COPY production.conf /etc/nginx/production.conf

CMD ["sh", "docker-entrypoint.sh"]
