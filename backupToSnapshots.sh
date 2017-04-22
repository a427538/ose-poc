#!/bin/bash
domain=mobilelife.de
fp_sshkey=f2:6f:8b:32:a7:60:96:a1:43:d8:65:d9:d7:07:aa:3a
for host in master1 master2 master3 etcd1 etcd2 etcd3 node1 node2 node3
do
	DropletID=`doctl compute droplet list --no-header --format ID,Name | grep $host | awk '{print $1}'`
	doctl compute droplet-action shutdown $DropletID --wait
	doctl compute droplet-action snapshot $DropletID --snapshot-name ${host}-`date +%s` --wait
	if [ `doctl compute snapshot list --no-header | grep $host | wc -l` -gt 1 ]
		then doctl compute snapshot delete `doctl compute snapshot list --no-header | grep $host | head -1 | awk '{print $1}'` -f
	fi
	doctl compute droplet delete $DropletID -f
	RecordID=`doctl compute domain records list $domain | grep $host | awk '{print $1}'`
	doctl compute domain records delete $domain $RecordID
done

