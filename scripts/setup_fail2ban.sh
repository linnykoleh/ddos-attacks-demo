#!/bin/bash

cat <<EOF > /etc/fail2ban/jail.local
[nginx-http-auth]
enabled  = true
filter   = nginx-http-auth
action   = iptables[name=HTTP, port=http, protocol=tcp]
logpath  = /var/log/nginx/error.log
maxretry = 3
bantime  = 600

[nginx-badbots]
enabled  = true
filter   = nginx-badbots
action   = iptables-multiport[name=BadBots, port="80,443", protocol=tcp]
logpath  = /var/log/nginx/access.log
maxretry = 5
bantime  = 3600
findtime = 600
EOF

cat <<EOF > /etc/fail2ban/filter.d/nginx-badbots.conf
[Definition]
failregex = ^<HOST> -.*GET.*HTTP.*(MJ12bot|AhrefsBot|SemrushBot|Baiduspider|YandexBot).*$
EOF

service fail2ban restart
