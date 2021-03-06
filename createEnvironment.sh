#!/bin/bash
domain=mobilelife.de
fp_sshkey=f2:6f:8b:32:a7:60:96:a1:43:d8:65:d9:d7:07:aa:3a
ImageID=`doctl compute image list | grep temp-nodocker | awk '{print $1}'`
for host in bastion lb etcd1 etcd2 etcd3
	./createDroplet.sh $host $ImageID &
done
ImageID=`doctl compute image list | grep temp-docker | awk '{print $1}'`
for host in master1 master2 master3 node1 node2 node3
do
	./createDroplet.sh $host $ImageID &
done

