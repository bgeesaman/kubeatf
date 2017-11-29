#!/bin/bash

###
# Downloads the role for the installer/tool to the roles dir
# and the tool to the releases directory
###

list-releases() {
  # List the installers downloaded to the releases folder
  msg "Available release tags/versions and date"

  cd "${RELEASES_DIR}"

  tool_name="${1-}"
  if [ ! -z "${tool_name}" ]; then 
    # Limit to a specific tool
    if [[ -f "${tool_name}/releases.json" ]]; then
      cat "${tool_name}/releases.json" | jq '.[]|{tag_name, created_at}|join(" ")' | tr -d '"'
    else
      echo "No ${tool_name} releases/commits found."
    fi
  else
    # List all
    for i in $(ls -1 */releases.json); do
      echo "+++ ${i}" | sed -e 's/\/releases.json//'
      cat "${i}" | jq '.[]|{tag_name, created_at}|join(" ")' | tr -d '"'
    done
  fi
}
