#!/usr/bin/env bash

function __set_current_script_installation() {
  _init_script "$0"
}

function __check_internet_connection() {
  if ! ping -c1 google.com &>/dev/null; then
    _error "$(_translate i18n_ERROR_INTERNET_CONNECTION_REQUIRED)"
  fi
}

function __install_via_package_manager() {
  local _package_name

  _package_name=$1

  # TODO: support other package managers (see https://github.com/nkaaf/nginx-letsencrypt-certification-management/issues/12)
  _echo "yellow" "$(_translate i18n_INFO_INSTALL_NOW "$_package_name")"
  _debug "$(_translate i18n_INSTALL_WITH_PACKAGE_MANAGER "$_package_name")"
  if ! sudo apt install --yes "$_package_name"; then
    _error "$(_translate i18n_ERROR_WHILE_INSTALLING_PACKAGE_MANAGER "$_package_name")"
  fi
  _echo "green" "$(_translate i18n_SUCCESS_INSTALLATION "$_package_name")"
}

# Install Docker via the installation script by the Docker Team. It is not recommended, but the best way to install Docker on different platforms.
# Not installing the Rootless Dockerd, because it would prevent the nginx to get the IP of the Requesting Client during the request
function __install_docker() {
  if ! _check_installed "curl"; then
    __install_via_package_manager "curl"
  fi

  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh

  user="$(id -un 2>/dev/null || true)"
  if [ "$user" != "root" ]; then
    sudo sh /tmp/get-docker.sh &>/dev/null
  else
    sh /tmp/get-docker.sh &>/dev/null
  fi

  # Post-Installation: Add Docker group to current user
  if ! _group_exists "docker"; then
    sudo groupadd docker &>/dev/null
  fi
  sudo usermod -aG docker "$USER" &>/dev/null
  newgrp docker
}

# DEPRECATED: not in use anymore and no warranty that result will be as expected
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
  # TODO: support other package managers (see https://github.com/nkaaf/nginx-letsencrypt-certification-management/issues/12)
  if ! _check_installed "apt" &>/dev/null; then
    _error "$(_translate i18n_ERROR_APT_IS_MISSING)"
  fi

  if ! _command_exists "docker"; then
    __install_docker
  fi

  if ! _check_installed "docker-compose-plugin"; then
    __install_via_package_manager "docker-compose-plugin"
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
