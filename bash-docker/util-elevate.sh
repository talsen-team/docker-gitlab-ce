#!/bin/bash

set -euo pipefail

VAR_NAME_USER="${1}"
VAR_ID_USER=$(id -u ${1})

cd $(cd "$(dirname "${0}")"; pwd)
export SUDO_ASKPASS=$(which ssh-askpass)
sudo --askpass --group ${VAR_NAME_USER} --user ${VAR_NAME_USER} /bin/bash ${2} ${@:3}