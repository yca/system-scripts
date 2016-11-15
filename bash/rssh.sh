#!/bin/bash

ip=$1

if [[ "ip" == "" ]]
then
	ip=192.168.1.196
fi

ssh-keygen -f "$HOME/.ssh/known_hosts" -R $ip
