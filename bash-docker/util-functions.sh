#!/bin/bash

function export_environment_file() {
  local VAR_PATH_FILE_ENV="${1}"

  if [ -f "${VAR_PATH_FILE_ENV}" ];
  then
      while IFS='' read -r VAR_LINE || [[ -n "${VAR_LINE}" ]];
      do
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

function navigate_to_script_containing_directory() {
    cd "$( cd $( dirname "${0}" ); pwd )"
}

function open_url_if_not_empty() {
    local VAR_URL="${1}"

    if [ "${VAR_URL}" = "" ];
    then
        echo -e "Opening URL ... $( text_color_yellow )skipped$( text_color_default )"
    else
        echo -e "Opening URL ${VAR_URL} ... $( text_color_green )done$( text_color_default )"
        
        xdg-open "${VAR_URL}"
    fi
}

function prepare_docker_compose_environment() {
    local VAR_FILE_APPLICATION_ENVIRONMENT="${1}"

    export_environment_file "${VAR_FILE_APPLICATION_ENVIRONMENT}"

    local VAR_PATH_APPLICATION_ROOT=$( read_environment_path_or_default "ENV_PATH_APPLICATION_ROOT" ".." )
    
    local VAR_NAME_APPLICATION=$( read_environment_variable_or_default "ENV_NAME_APPLICATION" "docker-unknown-application" )
    
    local VAR_PATH_DOCKER_COMPOSE=$( read_environment_variable_or_default "ENV_PATH_DOCKER_COMPOSE" "docker-compose" )
    
    local VAR_NAME_FILE_DOCKER_COMPOSE=$( read_environment_variable_or_default "ENV_NAME_DOCKER_COMPOSE_FILE" "docker-compose.yaml" )

    local VAR_PATH_FILE_DOCKER_COMPOSE=$( realpath "${VAR_PATH_APPLICATION_ROOT}/${VAR_PATH_DOCKER_COMPOSE}/${VAR_NAME_APPLICATION}/${VAR_NAME_FILE_DOCKER_COMPOSE}" )

    local VAR_PATH_VOLUMES_ROOT="${VAR_PATH_APPLICATION_ROOT}/volumes"

    export ENV_NAME_APPLICATION="${VAR_NAME_APPLICATION}"
    export ENV_PATH_APPLICATION_ROOT="${VAR_PATH_APPLICATION_ROOT}"
    export ENV_PATH_FILE_DOCKER_COMPOSE="${VAR_PATH_FILE_DOCKER_COMPOSE}"
    export ENV_PATH_VOLUMES_ROOT="${VAR_PATH_VOLUMES_ROOT}"
}

function read_environment_path_or_default() {
    echo $( realpath $( read_environment_variable_or_default ${@} ) )
}

function read_environment_variable_or_default() {
    local VAR_NAME_VARIABLE="${1}"
    local VAR_PATH_DEFAULT_VALUE="${2}"

    if [[ -v ${VAR_NAME_VARIABLE} ]];
    then
        echo "${!VAR_NAME_VARIABLE}"
    else
        echo "${VAR_PATH_DEFAULT_VALUE}"
    fi
}

function text_color_default() {
  echo "\033[0m"
}

function text_color_green() {
  echo "\033[0;32m"
}

function text_color_yellow() {
  echo "\033[0;33m"
}