#!/bin/bash

src=eth2
dst=eth3
snet=10.0.0.0/8

iptables -A FORWARD -o $src -i $dst -s $snet -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -o $src -j MASQUERADE

echo 1 > /proc/sys/net/ipv4/ip_forward
