#!/usr/bin/env bash

function __set_current_script_nginx_management() {
    _init_script "$0"
}

function _nginx_restart() {
  __set_current_script_nginx_management

  _debug "$(_translate i18n_DEBUG_RESTARTING_NGINX)"
  if ! docker exec "${NGINX_CONTAINER_NAME}" nginx -s reload; then
    _error "${NGINX_CONTAINER_NAME} $(_translate i18n_ERROR_RESTARTING_NGINX)"
  fi
  _echo "green" "$(_translate i18n_SUCCESS_RESTARTING_NGINX)"
}
