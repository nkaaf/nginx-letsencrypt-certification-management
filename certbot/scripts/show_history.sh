#!/usr/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

. "$_scripts_dir/utils.sh"

. "$_scripts_dir/common/i18n_core.sh"
_init_i18n "$1"
. "$_scripts_dir/i18n.sh"

while :; do
  echo -e "\n$(_translate i18n_HEADLINE_HISTORY_MENU)"
  echo "1. $(_translate i18n_OPTION_SHOW_CREATION_HISTORY)"
  echo "2. $(_translate i18n_OPTION_SHOW_UPDATE_HISTORY)"
  echo "3. $(_translate i18n_OPTION_SHOW_REVOCATION_HISTORY)"
  echo "4. $(_translate i18n_OPTION_EXIT_HISTORY_MENU)"
  echo "$(_translate i18n_ENTER_NUMBER_MENU)"
  read -r _answer
  echo "----------"

  case $_answer in
  1)
    if [ -f "/usr/local/share/exchange/history/get.history" ]; then
      cat "/usr/local/share/exchange/history/get.history"
    else
      echo "$(_translate i18n_INFO_CREATION_HISTORY_NOT_EXISTS)"
    fi
    ;;
  2)
    if [ -f "/usr/local/share/exchange/history/update.history" ]; then
      cat "/usr/local/share/exchange/history/update.history"
    else
      echo "$(_translate i18n_INFO_UPDATE_HISTORY_NOT_EXISTS)"
    fi
    ;;
  3)
    if [ -f "/usr/local/share/exchange/history/revoke.history" ]; then
      cat "/usr/local/share/exchange/history/revoke.history"
    else
      echo "$(_translate i18n_INFO_REVOKE_HISTORY_NOT_EXISTS)"
    fi
    ;;
  4)
    exit 0
    ;;
  *)
    _echo "red" "$(_translate i18n_ERROR_INCORRECT_OPTION)"
    ;;
  esac
done

exit 0
