FROM alpine:3.12

RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add grafana=7.3.6-r0 --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ && \
	apk add telegraf --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community  \
            sed \
	        curl \
            supervisor

WORKDIR /usr/share/grafana

COPY ./src/supervisord.conf /etc/supervisord.conf

COPY src/datasource.yml /usr/share/grafana/conf/provisioning/datasources/
COPY src/dashboard/*.json /usr/share/grafana/conf/provisioning/dashboards/mine/
COPY src/dashboard/data.yml /usr/share/grafana/conf/provisioning/dashboards/

EXPOSE 3000

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]