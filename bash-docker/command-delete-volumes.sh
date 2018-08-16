#!/bin/bash

set -eo pipefail

source ./util-functions.sh

PrepareDockerComposeEnvironment ${@}

echo -e "Deleting volumes at '${ENV_SERVICES_SERVER_GITLAB_CE_VOLUMES_ROOT}' ..."

rm -rf ${ENV_SERVICES_SERVER_GITLAB_CE_VOLUMES_ROOT}/*

echo -e "Deleting volumes at '${ENV_SERVICES_SERVER_GITLAB_CE_VOLUMES_ROOT}' ... $(TextColorGreen)done$(TextColorDefault)"