#!/bin/bash
domain=mobilelife.de
fp_sshkey=f2:6f:8b:32:a7:60:96:a1:43:d8:65:d9:d7:07:aa:3a
ImageID=`doctl compute image list | grep centos-7-x64 | awk '{print $1}'`
for host in master1 master2 master3 etcd1 etcd2 etcd3 node1 node2 node3
do
	newConfig=`doctl compute droplet create ${host}.${domain} --image $ImageID --region fra1 --size 2Gb --ssh-keys $fp_sshkey --wait --no-header --format ID,Name,PublicIPv4`
	# echo $SnapShotID
	doctl compute domain records create $domain --record-type A --record-name $host --record-data `echo $newConfig | awk '{print $3}'`
done

