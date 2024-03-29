#!/usr/bin/env bash

# Email Regex Validation: https://gist.github.com/guessi/82a73ee7eb2b1216eb9db17bb8d65dd1
function _validate_email() {
  local _email_regex

  _email_regex="^(([A-Za-z0-9]+((\.|\-|\_|\+)?[A-Za-z0-9]?)*[A-Za-z0-9]+)|[A-Za-z0-9]+)@(([A-Za-z0-9]+)+((\.|\-|\_)?([A-Za-z0-9]+)+)*)+\.([A-Za-z]{2,})+$"

  if ! [[ $1 =~ $_email_regex ]]; then
    _echo "red" "$(_translate i18n_ERROR_INVALID_EMAIL)"
    return 1
  fi
}

function _collect_data() {
  local _data

  _data="\tOS Information: $(cat /proc/version)\n"

  _data="${_data}\tThis Project Version: $(cat "$_main_dir/exchange/version")\n"

  if _command_exists "docker"; then
    _data="${_data}\t$(docker --version)\n"
  else
    _data="${_data}\tDocker is not installed!\n"
  fi

  if _check_installed "docker-compose-plugin"; then
    _data="${_data}\t$(docker compose version)\n"
  else
    _data="${_data}\tDocker Compose is not installed!\n"
  fi

  echo "$_data"
}

function _version_higher_or_equals_point_delimiter() {
  local _actually_version
  local _actually_version_array
  local _min_version
  local _min_version_array

  _actually_version="$1"
  _min_version="$2"

  mapfile -t _actually_version_array < <(echo -n "$_actually_version" | sed 's/\./\n/g')
  mapfile -t _min_version_array < <(echo -n "$_min_version" | sed 's/\./\n/g')

  for i in "${!_min_version_array[@]}"; do
    if [ "${_min_version_array[$i]}" -gt "${_actually_version_array[$i]}" ]; then
        return 1
    fi
  done
}
