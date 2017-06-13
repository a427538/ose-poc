#!/bin/bash
domain=mobilelife.de
fp_sshkey=f2:6f:8b:32:a7:60:96:a1:43:d8:65:d9:d7:07:aa:3a
for host in master1 master2 master3 etcd1 etcd2 etcd3 node1 node2 node3
do
	./createSnapshot.sh $host &
done

