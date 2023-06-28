#!/usr/bin/env bash

_author="Niklas Kaaf <nkaaf@protonmail.com>"
_author_github="https://github.com/nkaaf"
_github_repo="https://github.com/nkaaf/nginx-letsencrypt-certification-management"

_default="\e[0m"
_dim="\e[2m"
_red="\e[31m"
_green="\e[32m"
_yellow="\e[33m"

. "$_scripts_dir/common/i18n_common.sh"

function _init_script() {
  _current_script="$(basename "$(realpath "$1")")"
  export _current_script
}

function _echo() {
  local _color

  case $1 in
    debug)
      _color=$_dim
      ;;
    red)
      _color=$_red
      ;;
    green)
      _color=$_green
      ;;
    yellow)
      _color=$_yellow
      ;;
  esac

  echo -e "$_color$2$_default"
}

function _error() {
  local _error_text

  if [[ -n $1 ]]; then
    _echo "red" "ERROR: $1"
  fi

  _error_text="Error in the execution of $_current_script.\nIf this is an unexpected error, please contact the author and include following information:\n\t- This Installation Information:\n$(_collect_data)\n\t- The log if exists else the history of this outputs (make sure to hide sensitive data)\n\n\t$_author\t$_author_github\n\tRepository:\t$_github_repo"

  _echo "red" "$_error_text"

  if _is_set_and_function "$2"; then
    $2
  fi
  exit 1
}

function _is_set_and_function() {
  if _is_set "$1"; then
    if declare -F "$1" &>/dev/null; then
      return 0
    fi
  fi
  return 1
}

function _check_value_is_set() {
  local _var_name
  local _var_value

  _var_name=$1
  _var_value=${!_var_name}
  if ! _is_set "$_var_value"; then
    _error "$(_translate i18n_ERROR_PARAMETER_IS_UNSET "$_var_name")"
  fi
}

function _is_set() {
  if [ -z ${1+x} ] || [ -z "$1" ]; then
    return 1
  fi
}

function _debug() {
  if [ "$DEBUG" == true ]; then
    _echo "debug" "$1"
  fi
}

function _eval() {
  local _command

  _command=()
  for token; do
    _command+=("$(printf '%q' "$token")")
  done
  if ! eval "$(printf '%s' "${_command[*]}")"; then
    return 1
  fi
}

function _command_exists() {
  local _command

  _command=$1

  if ! command -v "$_command" >/dev/null 2>&1; then
    return 1
  fi
}

function _check_installed() {
  local _package_name

  _package_name=$1

  if ! dpkg --status "$_package_name" &>/dev/null; then
    return 1
  fi
}

function _group_exists() {
  local _group

  _group=$1

  if ! getent group "$_group" &>/dev/null; then
    return 1
  fi
}
