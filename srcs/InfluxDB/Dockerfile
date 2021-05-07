FROM alpine:3.12

RUN apk update && \
    apk add influxdb \
            supervisor && \
    apk add --no-cache --upgrade bash

COPY /src/setup.sh .

RUN chmod +x setup.sh

COPY ./src/supervisord.conf /etc/supervisord.conf

EXPOSE 8086

CMD ./setup.sh