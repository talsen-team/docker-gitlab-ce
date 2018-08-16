#!/bin/bash

set -eo pipefail

source ./util-functions.sh

PrepareDockerComposeEnvironment ${@}

export ENV_SERVICES_SERVER_MATRIX_SYNAPSE_COMMAND=start

docker-compose --file ${ENV_PATH_FILE_DOCKER_COMPOSE} start