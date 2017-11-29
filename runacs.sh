#!/bin/bash

run="$(date +%s)"
echo Create $run
./kubeatf create-cluster acs-default-az
echo Audit "$(date +%s)"
./kubeatf audit-cluster acs-default-az
echo Destroy "$(date +%s)"
./kubeatf destroy-cluster acs-default-az
done="$(date +%s)"
echo Complete $done
echo took "$(expr $done - $run)" seconds
