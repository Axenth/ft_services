FROM alpine:3.12

RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add telegraf --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ && \
    apk add supervisor

COPY ./src/setup.sh /tmp/setup.sh
RUN chmod +x ./tmp/setup.sh

COPY ./src/supervisord.conf /etc/supervisord.conf

CMD [ "sh", "-c", "/tmp/setup.sh" ]