#!/bin/bash

set -eo pipefail

source ./util-functions.sh

PrepareDockerComposeEnvironment ${@}

VAR_SHOW_URL=$(ReadEnvironmentOrEmpty "ENV_SERVICES_DEFAULT_URL")

OpenUrlIfNotEmpty "${VAR_SHOW_URL}"