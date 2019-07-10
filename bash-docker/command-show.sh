#!/bin/bash

set -euo pipefail

source ./util-functions.sh

prepare_docker_compose_environment ${@}

VAR_URL=$( read_environment_variable_or_default "ENV_URL_APPLICATION" "" )

open_url_if_not_empty "${VAR_URL}"