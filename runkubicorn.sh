#!/bin/bash

run="$(date +%s)"
echo Create $run
./kubeatf create-cluster kubicorn-default-aws
echo Audit "$(date +%s)"
./kubeatf audit-cluster kubicorn-default-aws
echo Destroy "$(date +%s)"
./kubeatf destroy-cluster kops-1.7.0-aws
done="$(date +%s)"
echo Complete $done
echo took "$(expr $done - $run)" seconds
