#!/bin/bash

set -e

mkdir -p IDS

for i in {0..17}; do 
	if [ -e IDS/$i.prv ]; then
		continue
	fi
	sudo zerotier/zerotier-one -d
	sleep 10
	sudo pkill -SIGINT zerotier-one
	sleep 5
	sudo pkill zerotier-one
	sleep 5
	sudo cat /var/lib/zerotier-one/identity.public > IDS/$i.pub
	sudo cat /var/lib/zerotier-one/identity.secret > IDS/$i.prv
	sudo rm /var/lib/zerotier-one/identity.public
	sudo rm /var/lib/zerotier-one/identity.secret
done
