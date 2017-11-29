#!/bin/bash

run="$(date +%s)"
echo Create $run
./kubeatf create-cluster aks-default-az
#echo Audit "$(date +%s)"
./kubeatf audit-cluster aks-default-az
#echo Destroy "$(date +%s)"
#./kubeatf destroy-cluster aks-default-az
done="$(date +%s)"
echo Complete $done
echo took "$(expr $done - $run)" seconds
