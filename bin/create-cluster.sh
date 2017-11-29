#!/bin/bash

###
# Calls the role's "create" action to build a uniquely named cluster
# and store the metadata in the local clusters folder
###

# TODO
_create-cluster_usage() {
  echo "Usage: ${0} create-cluster <profile_name>"
  echo ""
  exit
}

# TODO
create-cluster() {
  # Validate argument passed or show _docker_usage
  if [ -z "${1-}" ]; then _create-cluster_usage; fi

  profile_name="${1-}"
  if [[ -f "${PROJECT_PATH}/${PROFILES_DIR}/${profile_name}.yml" ]]; then
    echo "Run create cluster using profile ${profile_name}"
    ansible-playbook playbooks/create.yml -i "localhost," --extra-vars "full_profile_path=${PROJECT_PATH}/${PROFILES_DIR}/${profile_name}.yml"
  else
    echo "Invalid profile passed.  Could not find ${PROJECT_PATH}/${PROFILES_DIR}/${profile_name}.yml"
    exit 1
  fi
}
