#!/usr/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

. "$_scripts_dir/utils.sh"

. "$_scripts_dir/common/i18n_core.sh"
_init_i18n "$1"
. "$_scripts_dir/i18n.sh"

if ! _output_custom_list_of_certificates _cert_name; then
  exit 1
fi

_get_domains_of_certificate _domains "$_cert_name"

_command_to_execute=("certbot" "revoke" "--noninteractive" "--cert-path" "/etc/letsencrypt/live/$_cert_name/cert.pem")

function __choose_revoke_reason() {
  local -n _chosen_reason=$1
  local _revoke_reasons

  _revoke_reasons=("keycompromise" "affiliationchanged" "superseded" "cessationofoperation" "unspecified")

  while :; do
    echo -e "\n$(_translate i18n_HEADLINE_REVOKE_REASON_MENU)"
    echo "$(_translate i18n_INFO_REVOKE_REASON)"
    echo "1. $(_translate i18n_OPTION_KEY_COMPROMISE)" # https://kcitls.org/
    echo "2. $(_translate i18n_OPTION_AFFILIATION_CHANGED)"
    echo "3. $(_translate i18n_OPTION_SUPERSEDED)"
    echo "4. $(_translate i18n_OPTION_CESSATION_OF_OPERATION)"
    echo "5. $(_translate i18n_OPTION_MISCELLANEOUS)"
    echo "$(_translate i18n_ENTER_NUMBER_MENU "(Default: 5)")"
    read -r _reason
    echo "----------"

    if [ "$_reason" != "" ]; then
      if [[ -n ${_reason//[0-9]/} ]] ||[ "$_reason" -lt 1 ] || [ "$_reason" -gt 5 ]; then
        _echo "red" "$(_translate i18n_ERROR_INCORRECT_OPTION)"
      else
        _chosen_reason="${_revoke_reasons[$((_reason - 1))]}"
        return 0
      fi
    else
      _chosen_reason="${_revoke_reasons[4]}"
      return 0
    fi
  done
}

__choose_revoke_reason _reason

_command_to_execute+=("--reason" "$_reason")

if ! _eval "${_command_to_execute[@]}"; then
  _error "$(_translate i18n_ERROR_REVOKE_CERTIFICATE "${_command_to_execute[*]}")"
fi

echo "$(_translate i18n_SUCCESS_REVOKE_CERTIFICATE "$_cert_name")"

_write_action "revoke" "$_cert_name" "${_domains[@]}"

exit 0
