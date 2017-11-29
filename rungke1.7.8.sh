#!/bin/bash

run="$(date +%s)"
echo Create $run
./kubeatf create-cluster gke-1.7.8-gce
echo Audit "$(date +%s)"
./kubeatf audit-cluster gke-1.7.8-gce
echo Destroy "$(date +%s)"
./kubeatf destroy-cluster gke-1.7.8-gce
done="$(date +%s)"
echo Complete $done
echo took "$(expr $done - $run)" seconds
