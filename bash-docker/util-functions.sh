#!/bin/bash

function ExportDockerComposeFileNameOrKeepAlreadySetName() {
  export ENV_PATH_FILE_DOCKER_COMPOSE=$(ReadEnvironmentPathOrDefault "ENV_PATH_FILE_DOCKER_COMPOSE" "docker-compose.yaml")
}

function ExportEnvironmentFile() {
  local VAR_PATH_FILE_ENV="${1}"
  if [ -f "${VAR_PATH_FILE_ENV}" ]; then
    while IFS='' read -r VAR_LINE || [[ -n "${VAR_LINE}" ]]; do
      if [ "${VAR_LINE}" = "" ]; then
        continue;
      fi
      if [ "${VAR_LINE}" = "# private" ]; then
        break;
      fi
      if [[ ${VAR_LINE} != \#* ]]; then
        export "${VAR_LINE}"
      fi
    done < "${VAR_PATH_FILE_ENV}"
  else
    echo "Environment file '${VAR_PATH_FILE_ENV}' not found."
    exit 1
  fi
}

function NavigateToFolder() {
  cd "${1}"
}

function OpenUrlIfNotEmpty() {
  if [ "${1}" != "" ]; then
    echo -e "Opening URL ${1} ... $(TextColorGreen)done$(TextColorDefault)"
    xdg-open ${1}
  else
    echo -e "Opening URL ... $(TextColorYellow)skipped$(TextColorDefault)"
  fi
}

function PrepareDockerComposeEnvironment() {
  cd $(cd $(dirname ${0}); pwd)

  VAR_PATH_ROOT_ENV=$(ReadEnvironmentPathOrDefault "ENV_PATH_ROOT_ENV" "./../env")
  VAR_NAME_APPLICATION=$(ReadArgument "${1}")
  VAR_NAME_CONFIGURATION=$(ReadArgument "${2}")
  VAR_NAME_USER="${3}"
  VAR_PASS_USER="${4}"

  export ENV_PATH_ROOT_ENV=${VAR_PATH_ROOT_ENV}
  export ENV_PATH_FILE_SERVICES_DEFAULT_ENV_FILE="${VAR_PATH_ROOT_ENV}/${VAR_NAME_APPLICATION}/${VAR_NAME_CONFIGURATION}.env"
  ExportEnvironmentFile "${ENV_PATH_FILE_SERVICES_DEFAULT_ENV_FILE}"

  VAR_PATH_ROOT_DOCKER_COMPOSE=$(ReadEnvironmentPathOrDefault "ENV_PATH_ROOT_DOCKER_COMPOSE" "./../docker-compose")
  VAR_PATH_ROOT_DOCKER_COMPOSE="${VAR_PATH_ROOT_DOCKER_COMPOSE}/${VAR_NAME_APPLICATION}"

  export ENV_PATH_ROOT_DOCKER_COMPOSE=${VAR_PATH_ROOT_DOCKER_COMPOSE}

  NavigateToFolder "${VAR_PATH_ROOT_DOCKER_COMPOSE}"

  ExportDockerComposeFileNameOrKeepAlreadySetName

  export ENV_SERVICES_SERVER_MATRIX_SYNAPSE_COMMAND=version
}

function ReadArgument() {
  local VAR_ARG="${1}"
  if [ "${VAR_ARG}" = "" ]; then
    exit 1
  fi
  echo "${VAR_ARG}"
}

function ReadEnvironmentOrEmpty() {
  echo "${!1}"
}

function ReadEnvironmentPathOrDefault() {
  local VAR_ENV=${!1}
  if [ "${VAR_ENV}" = "" ]; then
    VAR_ENV="${2}"
  fi
  echo $(realpath ${VAR_ENV})
}

function TextColorDefault() {
  echo "\033[0m"
}

function TextColorGreen() {
  echo "\033[0;32m"
}

function TextColorYellow() {
  echo "\033[0;33m"
}