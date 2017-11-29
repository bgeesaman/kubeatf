#!/bin/bash

###
# Destroys a cluster by calling the 'destroy' action in the role.
# Requires a cluster instance id
###

# TODO
_destroy-cluster_usage() {
  echo "Usage: ${0} destroy <cluster_id>"
  echo ""
  exit
}

# TODO
destroy-cluster() {
  # Validate argument passed or show _docker_usage
  if [ -z "${1-}" ]; then _destroy-cluster_usage; fi
 
  cluster_id="${1-}"
  if [[ -f "${CLUSTERS_DIR}/${cluster_id}/profile.yml" ]]; then
    echo "Run destroy cluster ${cluster_id}"
    ansible-playbook playbooks/destroy.yml -i "localhost," --extra-vars "cluster_id=${cluster_id}"
  else
    echo "Invalid cluster_id. Must be one of:"
    ${0} list-clusters
    exit 1
  fi
}
