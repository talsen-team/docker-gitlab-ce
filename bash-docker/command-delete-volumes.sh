#!/bin/bash

set -eo pipefail

source ./util-functions.sh

PrepareDockerComposeEnvironment ${@}

echo -e "Deleting volumes at '${ENV_SERVICES_DEFAULT_VOLUMES_ROOT}' ..."

VAR_RESULT="";

if [ -z "${ENV_SERVICES_DEFAULT_VOLUMES_ROOT}" ]; then
  VAR_RESULT="$(TextColorYellow)skipped$(TextColorDefault)"
else
  rm -rf "${ENV_SERVICES_DEFAULT_VOLUMES_ROOT}/*"
  VAR_RESULT="$(TextColorGreen)done$(TextColorDefault)"
fi

echo -e "Deleting volumes at '${ENV_SERVICES_DEFAULT_VOLUMES_ROOT}' ... ${VAR_RESULT}"