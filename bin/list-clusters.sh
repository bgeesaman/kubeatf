#!/bin/bash

###
# Lists the clusters in the local clusters folder and basic details about
# them along with the cluster instance id
###

list-clusters() {
  # List the clusters in the clusters folder
  msg "Listing clusters"
  cd "${CLUSTERS_DIR}"
  ls -1 -d * 2> /dev/null
}
