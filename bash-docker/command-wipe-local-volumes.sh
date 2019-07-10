#!/bin/bash

set -euo pipefail

source ./util-functions.sh

function wipe_local_volumes() {
    VAR_NO_VOLUMES="true"
    
    if [ -d "${ENV_PATH_VOLUMES_ROOT}" ];
    then
        for VAR_VOLUME_NAME in $( ls --almost-all "${ENV_PATH_VOLUMES_ROOT}/" )
        do
            if [ ! -d "${ENV_PATH_VOLUMES_ROOT}/${VAR_VOLUME_NAME}" ];
            then
                continue
            fi
            
            echo -e "Removing local volume  ... $( text_color_green )${VAR_VOLUME_NAME}$( text_color_default )"
            rm -rf "${ENV_PATH_VOLUMES_ROOT}/${VAR_VOLUME_NAME}"
            VAR_NO_VOLUMES="false"
        done
    fi

    if [ "${VAR_NO_VOLUMES}" = "true" ];
    then
        echo -e     "Removing local volumes ... $( text_color_yellow )skipped$( text_color_default )"
    fi
}

prepare_docker_compose_environment ${@}

wipe_local_volumes
