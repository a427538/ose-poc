#!/bin/bash
domain=stich.app
fp_sshkey=f2:6f:8b:32:a7:60:96:a1:43:d8:65:d9:d7:07:aa:3a
host=$1
ImageID=$2
         newConfig=`doctl compute droplet create ${host}.${domain} --image $ImageID --region fra1 --size s-6vcpu-16gb --ssh-keys $fp_sshkey --wait --no-header --format ID,Name,PublicIPv4`
        # newConfig=`doctl compute droplet create ${host}.${domain} --image $ImageID --region fra1 --size 2gb --ssh-keys $fp_sshkey --wait --no-header --format ID,Name,PublicIPv4`
        # echo $SnapShotID
        doctl compute domain records create $domain --record-type A --record-name $host --record-data `echo $newConfig | awk '{print $3}'`

