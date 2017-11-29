#!/bin/bash

run="$(date +%s)"
echo Create $run
./kubeatf create-cluster kube-aws-v0.9.7
echo Audit "$(date +%s)"
./kubeatf audit-cluster kube-aws-v0.9.7-aws
echo Destroy "$(date +%s)"
./kubeatf destroy-cluster kube-aws-v0.9.7-aws
done="$(date +%s)"
echo Complete $done
echo took "$(expr $done - $run)" seconds
