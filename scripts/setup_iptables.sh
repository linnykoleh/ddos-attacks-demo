#!/bin/bash

# 1. Захист від SYN Flood атак (обмеження SYN пакетів)
iptables -A INPUT -p tcp --syn -m limit --limit 1/s -j ACCEPT
iptables -A INPUT -p tcp --syn -j DROP

# 2. Захист від UDP Flood атак (обмеження UDP пакетів)
iptables -A INPUT -p udp -m limit --limit 10/s -j ACCEPT
iptables -A INPUT -p udp -j DROP

# 3. Захист від ICMP Flood атак (обмеження ICMP пакетів)
iptables -A INPUT -p icmp -m limit --limit 1/s -j ACCEPT
iptables -A INPUT -p icmp -j DROP

# 4. Захист від Ping of Death (блокування великих ICMP пакетів)
iptables -A INPUT -p icmp --icmp-type echo-request -m length --length 65535 -j DROP

# 5. Блокування підозрілих або пошкоджених пакетів
iptables -A INPUT -m state --state INVALID -j DROP

# 6. Дозволяємо лише порти для веб-трафіку (HTTP, HTTPS) та SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 7. Відхиляємо всі інші вхідні пакети
iptables -A INPUT -j DROP

# Збереження правил iptables
iptables-save > /etc/iptables/rules.v4