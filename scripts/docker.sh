#!/usr/bin/env bash

function __set_current_script_docker() {
  _init_script "$0"
}

function __docker_compose_up() {
  local _pwd
  local _date

  _pwd=$(pwd)

  _date=$(date '+%Y-%m-%d %H:%M:%S')
  cd "$_main_dir"
  if ! docker compose up -d "$1" &>"$_main_dir/logs/docker_compose_up_$1_$_date.log"; then
    _error "$(_translate i18n_ERROR_FAILED_START_WITH_DOCKER_COMPOSE "$1" "$_main_dir/logs/docker_compose_up_$1_$_date.log")"
  else
    rm -f "$_main_dir/logs/docker_compose_up_$1_$_date.log"
  fi

  cd "$_pwd"
}

function __check_docker_container() {
  local _status
  local _date
  local _container_name
  local _image_name
  local _image_version

  _container_name=$1
  _image_name=$2
  _image_version=$3

  if ! docker container inspect -f '{{.State.Health.Status}}' "${_container_name}" &>/dev/null; then
    _debug "$(_translate i18n_DEBUG_STARTING_WITH_DOCKER_COMPOSE "$_container_name")"
    __docker_compose_up "${_container_name}"
  else
    if [[ $(docker container inspect -f '{{.Config.Image}}' "${_container_name}") != "${_image_name}:${_image_version}" ]]; then
      _debug "$(_translate i18n_DEBUG_RECREATE_WITH_DOCKER_COMPOSE "$_container_name")"
      __docker_compose_up "${_container_name}"
    fi
  fi

  _status=0
  while [ $_status == 0 ]; do
    _status="$(docker container inspect -f '{{.State.Status}}' "${_container_name}")"
    if ! [ "$_status" == "running" ]; then
      if [ "$_status" == "restarting" ]; then
        _date=$(date '+%Y-%m-%d %H:%M:%S')
        docker logs "${_container_name}" &>"$_main_dir/logs/docker_compose_restart_loop_${_container_name}_$_date.log"
        docker container rm -f "${_container_name}"
        _error "$(_translate i18n_ERROR_DOCKER_CONTAINER_START_LOOP "$_container_name" "$_main_dir/logs/docker_compose_restart_loop_${_container_name}_$_date.log")"
      elif [ "$_status" == "paused" ] || [ "$_status" == "created" ] || [ "$_status" == "exited" ] || [ "$_status" == "dead" ]; then
        __docker_compose_up "${_container_name}"
      fi
    fi

    _status=0
    if [ "$(docker container inspect -f '{{.State.Health.Status}}' "${_container_name}")" == "healthy" ]; then
      _status=1
      _debug "$(_translate i18n_DEBUG_CONTAINER_HEALTHY "$_container_name")"
    else
      sleep 1s
    fi
  done
}

function _check_docker_installation() {
  __set_current_script_docker

  _debug "$(_translate i18n_DEBUG_CHECKING_ALL_CONTAINER_UP)"
  __check_docker_container "${NGINX_CONTAINER_NAME}" "${NGINX_IMAGE_NAME}" "${NGINX_IMAGE_VERSION}"
  __check_docker_container "${CERTBOT_CONTAINER_NAME}" "${CERTBOT_IMAGE_NAME}" "${CERTBOT_IMAGE_VERSION}"
  _debug "$(_translate i18n_DEBUG_ALL_CONTAINER_UP)"
}
