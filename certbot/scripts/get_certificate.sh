#!/usr/bin/env bash

_config_changed=false

function cleanup() {
  if [ "$_config_changed" == true ]; then
    __revert_wildcard_config_changes
  fi
  exit
}

trap cleanup INT

. "$_scripts_dir/common/common.sh"
_init_script "$0"

. "$_scripts_dir/utils.sh"

. "$_scripts_dir/common/i18n_core.sh"
_init_i18n "$1"
. "$_scripts_dir/i18n.sh"

_wildcard=false
while :; do
  if [ ${#_domains} -ne 0 ]; then
    echo "$(_translate i18n_ADD_ANOTHER_DOMAIN_NAME)"
    read -r _answer
    if [ "$_answer" != "Y" ] && [ "$_answer" != "y" ] && [ "$_answer" != "J" ] && [ "$_answer" != "j" ]; then
      break
    fi
  fi
  echo "$(_translate i18n_ADD_DOMAIN_NAME)"
  read -r _domain
  if [[ -z "${_domain// /}" ]]; then
    _echo "red" "$(_translate i18n_INFO_EMPTY_DOMAIN)"
  else
    if [[ "$_domain" == "*."* ]]; then
      _wildcard=true
    fi
    _domains+=("$_domain")
  fi
done

_check_dns_entries "${_domains[@]}"

_command_to_execute=("certbot" "certonly")

if [ $_wildcard == true ]; then
  # Cannot create Wildcard cert with webroot authenticator, because manual is needed
  sed -i 's/^authenticator = webroot/#authenticator = webroot/' "/etc/letsencrypt/cli.ini"
  _config_changed=true
  _command_to_execute+=("--manual" "--server" "https://acme-v02.api.letsencrypt.org/directory" "--preferred-challenges" "dns-01")
else
  _command_to_execute+=("--noninteractive")
fi

function __revert_wildcard_config_changes() {
  # Revert change from Wildcard Certificate Creation
  sed -i 's/^#authenticator = webroot/authenticator = webroot/' "/etc/letsencrypt/cli.ini"
  _config_changed=false
}

for _i in "${!_domains[@]}"; do
  _command_to_execute+=("-d" "${_domains[$_i]}")
done

if ! _eval "${_command_to_execute[@]}"; then
  if [ $_wildcard == true ]; then
    __revert_wildcard_config_changes
  fi
  _error "$(_translate i18n_ERROR_CREATE_CERTIFICATE) '${_command_to_execute[*]}'"
fi

if [ $_wildcard == true ]; then
  __revert_wildcard_config_changes
fi

if [[ ${_domains[0]} == "*."* ]]; then
  _write_action "get" "${_domains[0]:2}" "${_domains[@]}"
else
  _write_action "get" "${_domains[0]}" "${_domains[@]}"
fi

exit 0
