#!/bin/bash

ip=$1

if [[ "ip" == "" ]]
then
	ip=196
fi

ssh-keygen -f "/home/caglar/.ssh/known_hosts" -R 192.168.1.$ip
