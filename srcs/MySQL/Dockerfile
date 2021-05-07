FROM alpine:3.12

RUN apk add mysql \
            mysql-client \
            supervisor

COPY ./src/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

COPY ./src/supervisord.conf /etc/supervisord.conf

VOLUME /var/lib/mysql
COPY ./src/my.cnf /etc/

CMD [ "sh", "-c", "/tmp/setup.sh" ]