#!/usr/bin/env bash

. "$_script_dir/common/common.sh"
_init_script "$@"

_command_to_execute=("certbot" "show_account")

_eval "${_command_to_execute[@]}"

exit 0