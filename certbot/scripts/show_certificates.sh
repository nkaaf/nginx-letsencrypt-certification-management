#!/usr/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

. "$_scripts_dir/utils.sh"

. "$_scripts_dir/common/i18n_core.sh"
_init_i18n "$1"
. "$_scripts_dir/i18n.sh"

_mode=$2

if [[ $_mode -eq 1 ]]; then
  if ! _output_custom_list_of_certificates _certificate; then
    exit 0
  fi
fi

_command_to_execute=("certbot" "certificates" "--noninteractive")

if [[ -n $_certificate ]]; then
  _command_to_execute+=("--cert-name" "$_certificate")
fi

if ! _eval "${_command_to_execute[@]}"; then
  if [[ $_mode -eq 0 ]]; then
    _error "$(_translate i18n_ERROR_SHOW_ALL_CERTIFICATES) '${_command_to_execute[*]}'"
  else
    _error "$(_translate i18n_ERROR_SHOW_CERTIFICATE) '${_command_to_execute[*]}'"
  fi
fi

exit 0
