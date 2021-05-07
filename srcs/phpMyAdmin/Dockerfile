FROM alpine:3.12

RUN apk update && \
	apk upgrade && \
    mkdir -p /www/tmp && \
    apk add php7 \
            php7-fpm \
            php7-opcache \
            php7-gd \
            php7-mysqli \
            php7-zlib \
            php7-curl \
            php7-mbstring \
            php7-json \
            php7-session \
            php7-zip \
	        wget \
	        curl \
	        jq \
	        nginx \
	        gettext \
	        supervisor

RUN mkdir -p /run/nginx

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
	tar -xzvf phpMyAdmin-5.0.1-english.tar.gz --strip-components=1 -C /www && \
	chmod 777 /www/tmp

RUN adduser -D -g 'www' www

COPY ./src/config.inc.php /www
COPY ./src/nginx.conf /etc/nginx/nginx.conf
COPY ./src/nginx.conf /etc/nginx.conf

RUN	apk add supervisor
COPY ./src/supervisord.conf /etc/supervisord.conf

COPY ./src/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php7/php-fpm.conf

EXPOSE 5000

CMD [ "sh", "-c", "/tmp/setup.sh ; /usr/bin/supervisord -c /etc/supervisord.conf" ]