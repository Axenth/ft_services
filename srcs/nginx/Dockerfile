FROM alpine:3.12

RUN apk update; \ 
    apk add nginx \
            openssl; \
    apk add openrc --no-cache

RUN adduser -D -g 'www' www

RUN mkdir /www

RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

RUN mkdir -p /run/nginx

COPY src/nginx.conf /etc/nginx/nginx.conf

RUN	apk add supervisor
COPY ./src/supervisord.conf /etc/supervisord.conf

RUN adduser -D user
RUN echo "user:password"|chpasswd

RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=EN/ST=75/L=Amsterdam/O=42/CN=jlensing' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt -addext "extendedKeyUsage = serverAuth"

COPY ./src/index.html /var/lib/nginx/html/index.html

COPY src/setup.sh ./setup.sh

RUN chmod +X /setup.sh

EXPOSE 80
EXPOSE 443
CMD [ "sh", "-c", "/tmp/setup.sh ; /usr/bin/supervisord -c /etc/supervisord.conf" ]