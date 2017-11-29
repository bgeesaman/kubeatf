#!/bin/bash

run="$(date +%s)"
echo Create $run
./kubeatf create-cluster heptio-master-aws
echo Audit "$(date +%s)"
./kubeatf audit-cluster heptio-master-aws
echo Destroy "$(date +%s)"
#./kubeatf destroy-cluster heptio-master-aws
done="$(date +%s)"
echo Complete $done
echo took "$(expr $done - $run)" seconds
