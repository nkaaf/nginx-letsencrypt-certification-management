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

  _command_name=$1

  if ! command -v "$_command_name" &>/dev/null; then
    return 1
  fi
}

function __install_via_package_manager() {
  local _package_name

  _package_name=$1

  # TODO: support other package managers (see https://github.com/nkaaf/nginx-letsencrypt-certification-management/issues/12)
  _echo "yellow" "$(_translate i18n_INFO_INSTALL_NOW "$_package_name")"
  _debug "$(_translate i18n_INSTALL_WITH_PACKAGE_MANAGER "$_package_name")"
  if ! sudo apt install "$_package_name"; then
    _error "$(_translate i18n_ERROR_WHILE_INSTALLING_PACKAGE_MANAGER "$_package_name")"
  fi
  _echo "green" "$(_translate i18n_SUCCESS_INSTALLATION "$_package_name")"
}

function __install_via_pip() {
  local _package_name

  _package_name=$1

  _echo "yellow" "$(_translate i18n_INFO_INSTALL_NOW "$_package_name")"
  _debug "$(_translate i18n_INSTALL_WITH_PIP "$_package_name")"
  if ! pip install "$1"; then
    _error "$(_translate i18n_ERROR_WHILE_INSTALLING_WITH_PIP " $_package_name")"
  fi
  _echo "green" "$(_translate i18n_SUCCESS_INSTALLATION "$_package_name")"
}

function __check_system_installation() {
  local _arch
  local _tmp_version

  _arch=$(uname -m)

  # TODO: support other package managers (see https://github.com/nkaaf/nginx-letsencrypt-certification-management/issues/12)
  if ! dpkg -l apt &>/dev/null; then
    _error "$(_translate i18n_ERROR_APT_IS_MISSING)"
  fi

  if ! __check_installed "docker"; then
    __install_via_package_manager "docker"
  fi

  if ! __check_installed "docker-compose"; then
    if [ "$_arch" != "x86_64" ]; then
      if ! __check_installed "python3"; then
        __install_via_package_manager "python3"
      fi

      if ! __check_installed "pip"; then
        __install_via_package_manager "python3-pip"
      fi

      _tmp_version=$(python --version | sed "s/Python //")
      if ! _version_higher_or_equals_point_delimiter "$_tmp_version" "3.6"; then
        _error "$(_translate i18n_ERROR_PYTHON_VERSION_MISMATCH)"
      fi

      __install_via_pip "docker-compose"
    else
      __install_via_package_manager "docker-compose"
    fi
  fi

  _tmp_version=$(docker-compose --version | sed "s/docker-compose version //" | sed "s/, build .*//")
  if ! _version_higher_or_equals_point_delimiter "$_tmp_version" "1.22.0"; then
    _error "$(_translate i18n_ERROR_DOCKER_COMPOSE_VERSION_MISMATCH)"
  fi
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
