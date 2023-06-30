#!/usr/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

_command_to_execute=("certbot" "show_account")

_eval "${_command_to_execute[@]}"

exit 0