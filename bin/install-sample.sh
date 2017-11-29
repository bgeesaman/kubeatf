#!/bin/bash

echo "Installing: `ls examples`"
echo ""
kubectl create -f examples/guestbook-controller.json
sleep 1
kubectl create -f examples/guestbook-service.json
sleep 1
kubectl create -f examples/redis-master-controller.json
sleep 1
kubectl create -f examples/redis-master-service.json
sleep 1
kubectl create -f examples/redis-slave-controller.json
sleep 1
kubectl create -f examples/redis-slave-service.json
sleep 1
kubectl create -f examples/default-deny.yml
sleep 1
kubectl create -f examples/guestbook-front.yml
sleep 1
kubectl create -f examples/guestbook-back.yml
echo "done."
