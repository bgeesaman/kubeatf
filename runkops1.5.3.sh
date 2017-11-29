#!/bin/bash

run="$(date +%s)"
echo Create $run
./kubeatf create-cluster kops-1.5.3-aws
echo Audit "$(date +%s)"
./kubeatf audit-cluster kops-1.5.3-aws
echo Destroy "$(date +%s)"
./kubeatf destroy-cluster kops-1.5.3-aws
done="$(date +%s)"
echo Complete $done
echo took "$(expr $done - $run)" seconds
