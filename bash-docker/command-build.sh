#!/bin/bash

set -eo pipefail

source ./util-functions.sh

PrepareDockerComposeEnvironment ${@}

docker-compose --file ${ENV_PATH_FILE_DOCKER_COMPOSE} build