#!/usr/bin/env bash

_usage="Usage: bash $(realpath "$0") [OPTIONS]
nginx Reverse-Proxy with Certification Management by Let's Encrypt and Certbot
[OPTIONS]:
  -h, --help, -?          displays this help text
  -d, --debug, -X         showing debug messages
  -l, --language <value>  choose language. Valid values for <value>: en, de

Important Links:
* nginx: https://nginx.org/
* Certbot: https://certbot.eff.org/
* Let's Encrypt: https://letsencrypt.org/"

function __set_current_script_main() {
  _init_script "$0"
}

_main_dir="$(dirname "$(realpath "$0")")"
export _main_dir
_scripts_dir="$_main_dir/scripts"
export _scripts_dir

. "$_scripts_dir/common/common.sh"
__set_current_script_main

. "$_scripts_dir/utils.sh"

. "$_scripts_dir/common/i18n_core.sh"
_init_i18n
. "$_scripts_dir/i18n.sh"

export DEBUG=false

while :; do
  case $1 in
    -l | --language)
      shift
      LANGUAGE="$1"
      export LANGUAGE
      _change_i18n "$LANGUAGE"
      ;;
    -h | --help | -\?)
      echo "$_usage"
      exit 0
      ;;
    -d | --debug | -X)
      DEBUG=true
      _debug "$(_translate i18n_DEBUG_MODE_ACTIVE)"
      ;;
    *)
      if [ "$1" != "" ]; then
        _echo "yellow" "$(_translate i18n_WARNING_NOT_PARSING "$1")"
      fi
      break
      ;;
  esac
  shift
done

echo "$(_translate i18n_PREPARATION)"

. "$_scripts_dir/installation.sh"
_check_installation

. "$_scripts_dir/docker.sh"
_check_docker_installation

_echo "green" "$(_translate i18n_SUCCESS_PREPARATION)"

. "$_scripts_dir/nginx_management.sh"
. "$_scripts_dir/certification_management.sh"

function __main_menu() {
  local _language_option
  local _answer

  while :; do
    __set_current_script_main

    echo -e "\n$(_translate i18n_HEADLINE_MAIN_MENU)"
    echo "1. $(_translate i18n_OPTION_MANAGE_CERTIFICATES)"
    echo "2. $(_translate i18n_OPTION_RESTART_NGINX)"

    _language_option="$(_translate i18n_OPTION_CHANGE_LANGUAGE)"
    if [ "$LANGUAGE" == "$i18n_EN" ]; then
      _language_option="$_language_option German"
    else
      _language_option="$_language_option Englisch"
    fi
    echo "3. $_language_option"

    echo "4. $(_translate i18n_OPTION_EXIT_PROGRAM)"
    echo "$(_translate i18n_ENTER_NUMBER_MENU "[1-4]")"
    read -r _answer
    echo "----------"
    case $_answer in
      1)
        _certbot_menu
        ;;
      2)
        _nginx_restart
        ;;
      3)
        if [ "$LANGUAGE" == "$i18n_EN" ]; then
          LANGUAGE="$i18n_DE"
        else
          LANGUAGE="$i18n_EN"
        fi
        ;;
      4)
        echo "$(_translate i18n_EXIT_PROGRAM)"
        exit 0
        ;;
      *)
        _echo "red" "$(_translate i18n_ERROR_INCORRECT_OPTION)"
        ;;
    esac
  done
}

__main_menu

exit 0
