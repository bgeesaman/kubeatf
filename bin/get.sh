#!/bin/bash

###
# Downloads the role if needed for the tool, and the tool by version
# installed into the releases folder
###

# TODO
_get_usage() {
  echo "Usage: ${0} get <cmd>"
  echo ""
  echo "${0} get releases <toolname> - List of available releases for that tool"
  echo "${0} get <toolname> <version> - Download a release version for a tool"
  echo ""
  exit
}

# TODO
get() {
  # Validate argument passed or show _docker_usage
  if [ -z "${1-}" ]; then _get_usage; fi
  if [ -z "${2-}" ]; then _get_usage; fi

  if [[ " ${1-} " == " releases " ]]; then
    # Run the role's "get_versions" action
    ansible-playbook playbooks/get.yml -i "localhost," --extra-vars "role_name=${2} role_action=get_versions release_version=''"
  else
    # Run the role's "get" action
    ansible-playbook playbooks/get.yml -i "localhost," --extra-vars "role_name=${1} role_action=get release_version=${2}"
  fi
}
