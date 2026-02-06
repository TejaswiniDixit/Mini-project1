#!/bin/bash

CONF="$(dirname "$0")/../config/firewall.conf"
source "$CONF"

iptables -F
iptables -X
iptables -t nat -F
iptables -t mangle -F

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p tcp --dport $SSH_PORT -m state --state NEW -j ACCEPT

iptables -A INPUT -p icmp -m limit --limit $ICMP_RATE -j ACCEPT

iptables -A INPUT -j LOG --log-prefix "FW-DROP: "
iptables -A INPUT -j DROP
