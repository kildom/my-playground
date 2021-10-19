#!/bin/bash

set -e

mkdir -p IDS

for i in {2..19}; do
	echo ---- Generating id for $i...
	echo start daemon
	sudo zerotier/zerotier-one -d
	sleep 10
	echo ctrl-c
	sudo pkill -SIGINT zerotier-one || true
	sleep 5
	echo kill
	sudo pkill zerotier-one || true
	sleep 5
	echo copy ids
	sudo cat /var/lib/zerotier-one/identity.public > IDS/$i.pub
	sudo cat /var/lib/zerotier-one/identity.secret > IDS/$i.prv
	echo remove old ids
	sudo rm /var/lib/zerotier-one/identity.public
	sudo rm /var/lib/zerotier-one/identity.secret
done

echo DONE
