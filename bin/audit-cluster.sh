#!/bin/bash

###
# Runs a special testing role that performs various tests
# against the cluster.  e2e, cis, security, etc 
###

# TODO
_audit-cluster_usage() {
  echo "Usage: ${0} audit <cluster_id>"
  echo ""
  exit
}

# TODO
audit-cluster() {
  # Validate argument passed or show _docker_usage
  if [ -z "${1-}" ]; then _audit-cluster_usage; fi
 
  cluster_id="${1-}"
  if [[ -d "${CLUSTERS_DIR}/${cluster_id}" ]]; then
    echo "Run audit cluster ${cluster_id}"
    ansible-playbook playbooks/audit.yml -i "localhost," --extra-vars "cluster_id=${cluster_id}"
  else
    echo "Invalid cluster_id: ${cluster_id} passed. Must be one of:"
    ${0} list-clusters
    exit 1
  fi
}
