#!/usr/bin/env bash

function __set_current_script_installation() {
  _init_script "$0"
}

function __check_internet_connection() {
  if ! ping -c1 google.com &>/dev/null; then
    _error "$(_translate i18n_ERROR_INTERNET_CONNECTION_REQUIRED)"
  fi
}

function __check_installed() {
  local _command_name
  local _app_name
  local _package_name

  _command_name=$1
  _app_name=$2
  _package_name=$3

  if ! command -v "$_command_name" &>/dev/null; then
    _echo "yellow" "$_app_name $(_translate i18n_INFO_INSTALL_NOW)"
    if ! sudo apt install "$_package_name"; then
      _error "$(_translate i18n_ERROR_WHILE_INSTALLING) $_app_name"
    fi
    _echo "green" "$_app_name $(_translate i18n_SUCCESS_INSTALLATION)"
  fi
}

function __check_system_installation() {
  if ! dpkg -l apt &>/dev/null; then
    # TODO: support other package manager? or install Docker (Compose) via plain installation script?
    _error "$(_translate i18n_ERROR_APT_IS_MISSING)"
  fi

  __check_installed "docker" "Docker" "docker"
  __check_installed "docker-compose" "Docker Compose" "docker-compose"
}

function __enter_email() {
  echo "$(_translate i18n_EMAIL_REQUIRED)"

  _correct=false
  while [ "$_correct" == false ]; do
    read -r _email
    if _validate_email "$_email"; then
      _correct=true
    fi
  done

  sed -i "s/USER_EMAIL=/USER_EMAIL=$_email/" "$_main_dir/.env"
}

function __manage_env() {
  if ! [ -f "$_main_dir/.env" ]; then
    cp "$_main_dir/.env.example" "$_main_dir/.env"
  fi

  . "$_main_dir/.env"

  _check_value_is_set "NGINX_IMAGE_VERSION"
  _check_value_is_set "NGINX_IMAGE_NAME"
  _check_value_is_set "NGINX_CONTAINER_NAME"
  _check_value_is_set "NGINX_NETWORK_NAME"
  _check_value_is_set "HTTP_PORT"
  _check_value_is_set "HTTPS_PORT"
  _check_value_is_set "CERTBOT_IMAGE_VERSION"
  _check_value_is_set "CERTBOT_IMAGE_NAME"
  _check_value_is_set "CERTBOT_CONTAINER_NAME"
  _check_value_is_set "CERTBOT_WEBROOT"

  if ! _is_set "$USER_EMAIL"; then
    __enter_email
  fi
}

function _check_installation() {
  __set_current_script_installation

  _debug "$(_translate i18n_DEBUG_CHECKING_INTERNET_CONNECTION)"
  __check_internet_connection
  _debug "$(_translate i18n_DEBUG_SUCCESS_INTERNET_CONNECTION)"

  _debug "$(_translate i18n_DEBUG_CHECKING_ENVIRONMENT_VARIABLES)"
  __manage_env
  _debug "$(_translate i18n_DEBUG_SUCCESS_ENVIRONMENT_VARIABLES)"

  _debug "$(_translate i18n_DEBUG_CHECKING_REQUIRED_SOFTWARE_INSTALLED)"
  __check_system_installation
  _debug "$(_translate i18n_DEBUG_SUCCESS_REQUIRED_SOFTWARE_INSTALLED)"
}
