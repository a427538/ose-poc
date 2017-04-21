#!/bin/bash
domain=mobilelife.de
fp_sshkey=f2:6f:8b:32:a7:60:96:a1:43:d8:65:d9:d7:07:aa:3a
for host in master1
do
	SnapShotID=`doctl compute snapshot list --no-header | grep ${host} | cut -d " " -f1`
	doctl compute droplet create ${host}.${domain} --image $SnapShotID --region fra1 --size 2Gb --ssh-keys $fp_sshkey --wait
	# echo $SnapShotID
done

