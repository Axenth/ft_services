FROM alpine:3.12

RUN apk upgrade; \
    apk add openssl \
            vsftpd \
            jq \
            curl \
            supervisor \
            strace

ENV API_URL=https://kubernetes

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=EN/ST=75/L=Amsterdam/O=42/CN=jlensing' -keyout /etc/ssl/certs/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

RUN mkdir -p /var/ftp

COPY ./src/supervisord.conf /etc/supervisord.conf

COPY ./src/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./src/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

EXPOSE 20 21 30000

CMD [ "sh", "-c", "/tmp/setup.sh" ]