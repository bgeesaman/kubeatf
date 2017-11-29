#!/bin/bash

set -ueo pipefail

###
# Utility Functions
###

# Format messages to the shell
msg() {
  echo "+++ $@"
}

# Alias for usage
help() { _usage; }

###
# Constants and paths
###

# Global
export PROJECT_NAME="kubeatf"
export PROJECT_PATH="$(pwd)"
# Docker build
export IMAGE_NAME="kubeatf"
export DOCKERFILE_DIR="docker/${IMAGE_NAME}/"
export IMAGE_VERSION="$(cat VERSION)"
# Use this instead of "docker" to avoid collision with the function name itself
export DOCKER_CLIENT="$(which docker)"

# Releases
export RELEASES_DIR="releases"

# Clusters
export CLUSTERS_DIR="clusters"
export PROFILES_DIR="profiles"
