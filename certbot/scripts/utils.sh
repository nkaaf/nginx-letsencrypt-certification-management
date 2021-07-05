#!/usr/bin/env bash

function _collect_data() {
  local _data

  _data="\tThis Project Version: $(cat "/usr/local/share/exchange/version")\n"

  _data="${_data}\t$(certbot --version)\n"

  echo "$_data"
}

function _check_dns_entries() {
  local _domains
  local _dns_not_exists
  local _error_text

  _domains=("$@")
  for _to_check in "${_domains[@]}"; do
    if [[ $_to_check =~ ^\*\..* ]]; then
      if ! nslookup "${_to_check:2}" &>/dev/null; then
        _dns_not_exists+=("${_to_check:2} ($_to_check)")
      fi
    else
      if ! nslookup "$_to_check" &>/dev/null; then
        _dns_not_exists+=("$_to_check")
      fi
    fi
  done
  if [ ${#_dns_not_exists[@]} -ne 0 ]; then
    _error_text="$(_translate i18n_ERROR_NO_DNS_ENTRIES)\n"
    for _i in "${!_dns_not_exists[@]}"; do
      _error_text="$_error_text\t- ${_dns_not_exists[$_i]}"
      if [ "$_i" -ne $((${#_dns_not_exists[@]} - 1)) ]; then
        _error_text="$_error_text\n"
      fi
    done
    _error "$_error_text"
  fi
}

function __get_array_of_all_certificate_names() {
  local _certificates
  local -n _names=$1
  local -n _domains=$2

  _certificates=$(certbot certificates)
  mapfile -t _names < <(echo "$_certificates" | awk '$0 ~ /^ *Certificate Name:/' | cut -d ":" -f2 | sed 's/ //')
  mapfile -t _domains < <(echo "$_certificates" | awk '$0 ~ /^ *Domains:/' | cut -d ":" -f2 | sed 's/ //')
}

function _get_domains_of_certificate() {
  local _certificate_names
  local _certificate_domains
  local -n _domains_var=$1
  local _cert_name

  _cert_name=$2

  __get_array_of_all_certificate_names _certificate_names _certificate_domains

  for _i in "${!_certificate_names[@]}"; do
    if [ "${_certificate_names[$_i]}" == "$_cert_name" ]; then
      _domains_var=${_certificate_domains[$_i]}
    fi
  done
}

function _output_custom_list_of_certificates() {
  local _certificate_names
  local _certificate_domains
  local -n _chosen_certificate=$1

  __get_array_of_all_certificate_names _certificate_names _certificate_domains

  if [ ${#_certificate_names[@]} -gt 0 ]; then
    while :; do
      echo -e "\n$(_translate i18n_HEADLINE_SPECIFIC_CERTIFICATE_MENU)"
      for _i in "${!_certificate_names[@]}"; do
        echo "$((_i + 1)): ${_certificate_names[$_i]} (Domains: ${_certificate_domains[$_i]})"
      done
      echo "$(_translate i18n_ENTER_NUMBER_MENU)"
      read -r _chosen_certificate
      echo "----------"

      if [[ -n ${_chosen_certificate//[0-9]/} ]] || [ "$_chosen_certificate" -lt 1 ] || [ "$_chosen_certificate" -gt ${#_certificate_names[@]} ]; then
        _echo "red" "$(_translate i18n_ERROR_INCORRECT_OPTION)"
      else
        _chosen_certificate=${_certificate_names[$((_chosen_certificate - 1))]}
        return 0
      fi
    done
  else
    _echo "yellow" "$(_translate i18n_INFO_NO_CERTIFICATES)"
    return 1
  fi
}

function _write_action() {
  local _action
  local _certificate
  local _domains
  local _line

  _action=$1
  shift
  _certificate=$1
  shift

  _domains=()
  if [ "$_action" == "update" ] || [ "$_action" == "get" ]; then
    _domains=("$@")
  fi

  _line="$_certificate"

  for _domain in "${_domains[@]}"; do
    _line="$_line/$_domain"
  done

  echo "$_line" >"/usr/local/share/exchange/actions/$_action.action"

  _line="$(date '+%Y-%m-%d %H:%M:%S'): $_certificate ("
  for _domain in "${_domains[@]}"; do
    _line="$_line$_domain "
  done
  _line="${_line::-1})\n"
  echo -e "$_line" >>"/usr/local/share/exchange/history/$_action.history"
}
