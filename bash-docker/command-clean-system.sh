#!/bin/bash

set -eo pipefail

source ./util-functions.sh

PrepareDockerComposeEnvironment ${@}

VAR_NO_CONTAINERS="true"
for VAR_CONTAINER_ID in $(docker ps     -a -q --filter status=exited --filter status=dead)
do
  echo -e "Removing container  ... $(TextColorGreen)${VAR_CONTAINER_ID}$(TextColorDefault)"
  docker rm  ${VAR_CONTAINER_ID}
  VAR_NO_CONTAINERS="false"
done

if [ "${VAR_NO_CONTAINERS}" = "true" ]; then
  echo -e "Removing containers ... $(TextColorYellow)skipped$(TextColorDefault)"
fi

VAR_NO_IMAGES="true"
for VAR_IMAGE_ID     in $(docker images    -q --filter dangling=true)
do
  echo -e "Removing image      ... $(TextColorGreen)${VAR_IMAGE_ID}$(TextColorDefault)"
  docker rmi ${VAR_IMAGE_ID}
  VAR_NO_IMAGES="false"
done

if [ "${VAR_NO_IMAGES}" = "true" ]; then
  echo -e "Removing images     ... $(TextColorYellow)skipped$(TextColorDefault)"
fi

echo -e "Removing networks   ... $(TextColorGreen)done$(TextColorDefault)"
docker network prune --force