#!/bin/bash

set -euo pipefail

source ./util-functions.sh

function wipe_stale_volumes() {
    echo -e     "Removing volumes    ... $( text_color_green )done$( text_color_default )"
    docker volume prune --force
}

wipe_stale_volumes
