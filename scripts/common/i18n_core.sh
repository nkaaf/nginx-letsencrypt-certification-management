#!/usr/bin/env bash

export i18n_EN="0"
export i18n_EN_STR="en"
export i18n_DE="1"
export i18n_DE_STR="de"

_incorrect_language="Incorrect language was passed by, defaulting to English."

function _init_i18n() {
  if [ -z ${1+x} ]; then
    LANGUAGE=$i18n_EN
  elif [ "$1" == "$i18n_EN" ]; then
    LANGUAGE=$i18n_EN
  elif [ "$1" == "$i18n_DE" ]; then
    LANGUAGE=$i18n_DE
  else
    LANGUAGE=$i18n_EN
    _echo "yellow" "$_incorrect_language"
  fi
}

function _change_i18n() {
  if [ "$1" == "$i18n_EN_STR" ]; then
    LANGUAGE=$i18n_EN
  elif [ "$1" == "$i18n_DE_STR" ]; then
    LANGUAGE=$i18n_DE
  else
    LANGUAGE=$i18n_EN
    _echo "yellow" "$_incorrect_language"
  fi
}

function _translate() {
  local _i18n_str
  local _i18n_name
  local _parameters
  local _parameters_size

  _i18n_name=$1
  shift
  _parameters=("$@")

  if ! _check_value_is_set "$_i18n_name"; then
    _error "$(_translate i18n_ERROR_PARAMETER_IS_UNSET "$_i18n_name")"
  fi

  _i18n_str="${_i18n_name}[$LANGUAGE]"
  _i18n_str=${!_i18n_str}

  _parameters_size=${#_parameters[@]}

  for ((i = 0; i < _parameters_size; i++)); do
    _i18n_str=${_i18n_str/\{\}/${_parameters[$i]}}
  done

  echo -n "$_i18n_str"
}
