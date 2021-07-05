#!/usr/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

. "$_scripts_dir/utils.sh"

. "$_scripts_dir/common/i18n_core.sh"
_init_i18n "$1"
. "$_scripts_dir/i18n.sh"

_command_to_execute=("certbot" "certonly" "--noninteractive")

if ! _output_custom_list_of_certificates _cert_name; then
  exit 1
fi

_command_to_execute+=("--cert-name" "$_cert_name")

function __choose_new_domains() {
  local _answer
  local -n _new_domains=$2
  local _current_domains
  local _hit

  _new_domains=()
  _hit=false

  _get_domains_of_certificate _current_domains "$1"
  _current_domains=($_current_domains)

  while :; do
    echo "$(_translate i18n_HEADLINE_CHOOSE_UPDATED_DOMAINS)"
    echo "$(_translate i18n_CURRENT_DOMAINS) ${_current_domains[*]}"
    if [ ${#_new_domains} -ne 0 ]; then
      echo "$(_translate i18n_NEW_DOMAINS) ${_new_domains[*]}"
      echo "$(_translate i18n_QUESTION_ADD_ANOTHER)"
      read -r _answer
      if [ "$_answer" != "Y" ] && [ "$_answer" != "y" ] && [ "$_answer" != "J" ] && [ "$_answer" != "j" ]; then
        return 0
      fi
    fi
    echo "$(_translate i18n_ENTER_DOMAIN_NAME)"
    read -r _answer

    if [ "$_answer" == "A" ] || [ "$_answer" == "a" ]; then
      if [ $_hit == false ]; then
        _hit=true
        for _eventually_new_domain in "${_current_domains[@]}"; do
          _contains=false
          for _new_domain in "${_new_domains[@]}"; do
            if [ "$_new_domain" == "$_eventually_new_domain" ]; then
              _contains=true
            fi
          done
          if [ $_contains == false ]; then
            _new_domains+=("${_eventually_new_domain}")
          fi
        done
      fi
    elif [[ -z "${_answer// /}" ]]; then
      _echo "red" "$(_translate i18n_INFO_EMPTY_DOMAIN)"
    else
      _new_domains+=("$_answer")
    fi
  done
}

_domains=()
__choose_new_domains "$_cert_name" _domains

_check_dns_entries "${_domains[@]}"

for _domain in "${_domains[@]}"; do
  _command_to_execute+=("-d" "$_domain")
done

if _eval "${_command_to_execute[@]}"; then
  echo "$_cert_name $(_translate i18n_SUCCESS_UPDATE_CERTIFICATE)"
else
  _error "$(_translate i18n_ERROR_UPDATE_CERTIFICATE) '${_command_to_execute[*]}'"
fi

_write_action "update" "$_cert_name" "${_domains[@]}"

exit 0
