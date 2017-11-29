#!/bin/bash

. targets.sh

function reach_url() {
  URL="${1-}"
  HEADER="${2-}"
  CMD="$(curl --connect-timeout 3 -sk -H "${HEADER}" ${URL})"
  if [ $? -ne 0 ]; then
    echo "False"
  else
    if [[ "$CMD" =~ orbidden ]] || [[ "$CMD" =~ nauthorized ]] || [[ "$CMD" =~ "cannot list namespaces" ]] || [[ "$CMD" =~ "an error" ]]; then
      echo "False"
    else
      echo "True"
    fi
  fi
}

function check_file() {
  FILE="${1-}"
  if [ -f "${FILE}" ]; then
    echo "True"
  else
    echo "False"
  fi
}

SCORE_ADDED=0
SCORE_TOTAL=0
function score() {
  CHECKSCORE="${1-}"
  TOTALSCORE="${2-}"
  SCORE_ADDED=$(expr $CHECKSCORE + $SCORE_ADDED)
  SCORE_TOTAL=$(expr $TOTALSCORE + $SCORE_TOTAL)
}

# External Access
echo -n " 1 - Access External HTTP Site (http://whatismyip.org): "
reach_url "http://whatismyip.org"

# Image list access
echo -n " 2 - Access DockerHub Index (HTTPS) Site (https://index.docker.io): "
reach_url "https://index.docker.io"

# Image pull access
echo -n " 3 - Access DockerHub Registry (HTTPS) Site (https://registry-1.docker.io): "
reach_url "https://registry-1.docker.io"

# Automount token
echo -n " 4 - Access Locally Mounted Kube SA Token: "
check_file "/var/run/secrets/kubernetes.io/serviceaccount/token"

# Reach API
echo -n " 5 - Access Kube API Server (https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_SERVICE_PORT}): "
reach_url "https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_SERVICE_PORT}"

# Use API
echo -n " 6 - Access Kube API Server with Local SA Token (https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_SERVICE_PORT}/api/v1/namespaces): "
reach_url "https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_SERVICE_PORT}/api/v1/namespaces" "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"

# Kubelet on self
if [ ! -z "${KUBELET_URL}" ]; then
  echo -n " 7 - Access Kubelet on local host (${KUBELET_URL}): "
  reach_url "${KUBELET_URL}"
fi

# Kubelet on another worker
if [ ! -z "${KUBELET_OTHER_WORKER_URL}" ]; then
  echo -n " 8 - Access Kubelet on another worker host (${KUBELET_OTHER_WORKER_URL}): "
  reach_url "${KUBELET_OTHER_WORKER_URL}"
fi

# Kubelet on a master
if [ ! -z "${KUBELET_MASTER_URL}" ]; then
  echo -n " 9 - Access Kubelet on master host (${KUBELET_MASTER_URL}): "
  reach_url "${KUBELET_MASTER_URL}"
fi

# Kubelet RO on self
if [ ! -z "${KUBELET_RO_URL}" ]; then
  echo -n "10 - Access Kubelet RO on local host (${KUBELET_RO_URL}): "
  reach_url "${KUBELET_RO_URL}"
fi

# Kubelet RO on another worker
if [ ! -z "${KUBELET_OTHER_WORKER_RO_URL}" ]; then
  echo -n "11 - Access Kubelet RO on another worker host (${KUBELET_OTHER_WORKER_RO_URL}): "
  reach_url "${KUBELET_OTHER_WORKER_RO_URL}"
fi

# Kubelet RO on a master
if [ ! -z "${KUBELET_MASTER_RO_URL}" ]; then
  echo -n "12 - Access Kubelet RO on master host (${KUBELET_MASTER_RO_URL}): "
  reach_url "${KUBELET_MASTER_RO_URL}"
fi

# Kube-Dashboard
if [ ! -z "${DASHBOARD_URL}" ]; then
  echo -n "13 - Access Kube Dashboard (${DASHBOARD_URL}): "
  reach_url "${DASHBOARD_URL}"
fi

# Heapster
if [ ! -z "${HEAPSTER_URL}" ]; then
  echo -n "14 - Access Heapster Metrics (${HEAPSTER_URL}): "
  reach_url "${HEAPSTER_URL}"
fi

# ETCD
if [ ! -z "${ETCD_URL}" ]; then
  echo -n "15 - Access ETCD Directly (${ETCD_URL}): "
  reach_url "${ETCD_URL}"
fi

# Calico ETCD
if [ ! -z "${CALICO_ETCD_URL}" ]; then
  echo -n "16 - Access Calico ETCD Directly (${CALICO_ETCD_URL}): "
  reach_url "${CALICO_ETCD_URL}"
fi

# Detect AWS
if [ -f "/sys/hypervisor/uuid" ] && [ "`head -c 3 /sys/hypervisor/uuid`" == "ec2" ]; then
  echo -n "20 - Access AWS EC2 API (https://ec2.${AWS_REGION}.amazonaws.com): "
  reach_url "https://ec2.${AWS_REGION}.amazonaws.com"
  
  echo -n "21 - Access AWS S3 API (https://ec2.${AWS_REGION}.amazonaws.com): "
  reach_url "https://ec2.${AWS_REGION}.amazonaws.com"

  echo -n "22 - Access EC2 Userdata (http://169.254.169.254/latest/user-data): "
  reach_url "http://169.254.169.254/latest/user-data"

  echo -n "23 - Access EC2 IAM Credentials (http://169.254.169.254/latest/meta-data/iam/info): "
  reach_url "http://169.254.169.254/latest/meta-data/iam/info"
fi

# Detect Google
if [ -f /proc/version ] && [[ "$(cat /proc/version)" =~ chrome ]]; then
  echo -n "30 - Access GCE Metadata API: "
  reach_url "http://metadata.google.internal/0.1/meta-data/attributes/user-data" "X-Google-Metadata-Request: True"

  echo -n "31 - Access GKE kube-env attribute: "
  reach_url "http://metadata.google.internal/0.1/meta-data/attributes/kube-env" "X-Google-Metadata-Request: True"

  echo -n "32 - Access GCE Instance Credentials: "
  reach_url "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token" "X-Google-Metadata-Request: True"
fi
