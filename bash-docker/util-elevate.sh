#!/bin/bash

set -euo pipefail

function export_askpass_gui_prompt_for_sudo() {
    export SUDO_ASKPASS="$( which ssh-askpass )"
}

function navigate_to_script_containing_directory() {
    cd "$( cd $( dirname "${0}" ); pwd )"
}

VAR_USER_NAME="${1}"
VAR_FILE_APPLICATION_ENVIRONMENT="${2}"

navigate_to_script_containing_directory

export_askpass_gui_prompt_for_sudo

sudo --askpass --group ${VAR_USER_NAME} --user ${VAR_USER_NAME} /bin/bash ${2} ${@:3}