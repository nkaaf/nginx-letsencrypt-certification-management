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

# TODO: translate with parameters
function _translate() {
  local _i18n_str

  _i18n_str="${1}[$LANGUAGE]"
  echo -n "${!_i18n_str}"
}
