#!/bin/bash

set -eo pipefail

source ./util-functions.sh

PrepareDockerComposeEnvironment ${@}

VAR_HAS_EXECUTED=false

while read -r VAR_COMMAND || [[ -n "${VAR_COMMAND}" ]]; do
  VAR_HAS_EXECUTED=true
  echo -e "Executing command: ${VAR_COMMAND} ..."
  echo -e ""

  docker exec ${1} ${VAR_COMMAND}

  echo -e ""
  echo -e "Executing command: ${VAR_COMMAND} ... $(TextColorGreen)done$(TextColorDefault)"
done < "./../../.bash-docker.command"

if [ "${VAR_HAS_EXECUTED}" = "false" ]; then
  echo -e "Executing command ... $(TextColorYellow)skipped$(TextColorDefault)"
  exit 0
fi