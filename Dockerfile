FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY ./html/index.html /var/www/html/index.html

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY ./scripts/setup_iptables.sh /usr/local/bin/setup_iptables.sh
COPY ./scripts/setup_fail2ban.sh /usr/local/bin/setup_fail2ban.sh

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
