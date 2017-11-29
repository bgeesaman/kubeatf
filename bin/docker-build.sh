#!/bin/bash

###
# Builds the tool locally using docker
###

# TODO
_docker-build_usage() {
  echo "Usage: ${0} docker-build"
  echo ""
  echo "${0} docker-build - Builds the MaaS container (MaaS)"
  echo ""
  exit
}

# TODO
docker-build() {
  msg "Run docker build for the container locally..."
  ${DOCKER_CLIENT} build -t "${IMAGE_NAME}/${IMAGE_VERSION}" "${DOCKERFILE_DIR}"
  msg "Running the new container..."
  ${DOCKER_CLIENT} run --rm "${IMAGE_NAME}/${IMAGE_VERSION}"
  msg "done."
}
