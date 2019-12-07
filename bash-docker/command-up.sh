#!/bin/bash

set -euo pipefail

source ./util-functions.sh

prepare_docker_compose_environment ${@}

docker-compose --compatibility --file ${ENV_PATH_FILE_DOCKER_COMPOSE} up --detach