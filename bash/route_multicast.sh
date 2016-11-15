#!/bin/bash

iface=$1
route add -net 224.0.0.0 netmask 240.0.0.0 dev $iface
echo 0 > /proc/sys/net/ipv4/conf/$iface/rp_filter

