#!/bin/bash


set -e

# Parameters
# $1 domain
# $2 ip file
# $3 gw or dev
# $4 route or interface

if [ -f "$2" ]; then
   	# Delete old route table
	OLD_IP=`cat $2`
	for IP in $(echo $OLD_IP); do
		route del $IP
	done
fi

NEW_IP=`nslookup -4 $1 | grep 'Address: ' | sed 's/[[:alpha:]:]//g' | grep '\.'`

for IP in $(echo $NEW_IP); do
	# Add route
	route add $IP $3 $4
done

echo $NEW_IP > $2
