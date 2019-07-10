#!/bin/bash

set -euo pipefail

source ./util-functions.sh

function wipe_stale_containers() {
    VAR_NO_CONTAINERS="true"

    for VAR_CONTAINER_ID in $( docker ps     --all --quiet --filter status=exited --filter status=dead )
    do
        echo -e     "Removing container     ... $( text_color_green )${VAR_CONTAINER_ID}$( text_color_default )"
        docker rm  ${VAR_CONTAINER_ID}
        VAR_NO_CONTAINERS="false"
    done

    if [ "${VAR_NO_CONTAINERS}" = "true" ];
    then
        echo -e     "Removing containers    ... $( text_color_yellow )skipped$( text_color_default )"
    fi
}

function wipe_stale_images() {
    VAR_NO_IMAGES="true"

    for VAR_IMAGE_ID     in $( docker images       --quiet --filter dangling=true )
    do
        echo -e     "Removing image         ... $( text_color_green )${VAR_IMAGE_ID}$( text_color_default )"
        docker rmi ${VAR_IMAGE_ID}
        VAR_NO_IMAGES="false"
    done

    if [ "${VAR_NO_IMAGES}" = "true" ];
    then
        echo -e     "Removing images        ... $( text_color_yellow )skipped$( text_color_default )"
    fi
}

function wipe_stale_networks() {
    echo -e         "Removing networks      ... $( text_color_green )done$( text_color_default )"
    docker network prune --force
}

wipe_stale_containers
wipe_stale_images
wipe_stale_networks
