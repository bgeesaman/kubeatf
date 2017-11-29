#!/bin/bash

run="$(date +%s)"
echo Create $run
./kubeatf create-cluster tectonic-1.7.1-tectonic.2-aws
echo Audit "$(date +%s)"
./kubeatf audit-cluster tectonic-1.7.1-tectonic.2-aws
echo Destroy "$(date +%s)"
./kubeatf destroy-cluster tectonic-1.7.1-tectonic.2-aws
done="$(date +%s)"
echo Complete $done
echo took "$(expr $done - $run)" seconds
