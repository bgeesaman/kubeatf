#!/bin/bash

###
# Lists the profiles_path/*.yml files
###

list-profiles() {
  msg "Available cluster installation profiles"
  cd "${PROFILES_DIR}"
  ls -1 *.yml | sed -e 's/\.yml$//' 2> /dev/null
}
