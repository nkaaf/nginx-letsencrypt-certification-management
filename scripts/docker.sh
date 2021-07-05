#!/usr/bin/env bash

function __set_current_script_docker() {
  _init_script "$0"
}

function __docker_compose_up() {
  local _pwd
  local _date

  _pwd=$(pwd)

  _date=$(date '+%Y-%m-%d %H:%M:%S')
  cd "$_main_dir" || _error "$_main_dir $(_translate i18n_ERROR_DIRECTORY_NOT_EXIST)"
  if ! docker-compose up -d "$1" &>"$_main_dir/logs/docker_compose_up_$1_$_date.log"; then
    _error "$1 $(_translate i18n_ERROR_FAILED_START_WITH_DOCKER_COMPOSE) $_main_dir/logs/docker_compose_up_$1_$_date.log"
  else
    rm -f "$_main_dir/logs/docker_compose_up_$1_$_date.log"
  fi

  cd "$_pwd" || _error "$_pwd $(_translate i18n_ERROR_DIRECTORY_NOT_EXIST)"
}

function __check_docker_container() {
  local _status
  local _date
  local _container_name

  _container_name=$1

  if ! docker container inspect -f '{{.State.Health.Status}}' "${_container_name}" &>/dev/null; then
    _debug "${_container_name} $(_translate i18n_DEBUG_STARTING_WITH_DOCKER_COMPOSE)"
    __docker_compose_up "${_container_name}" -d
  fi

  _status=0
  while [ $_status == 0 ]; do
    _status="$(docker container inspect -f '{{.State.Status}}' "${_container_name}")"
    if ! [ "$_status" == "running" ]; then
      if [ "$_status" == "restarting" ]; then
        _date=$(date '+%Y-%m-%d %H:%M:%S')
        docker logs "${_container_name}" &>"$_main_dir/logs/docker_compose_restart_loop_${_container_name}_$_date.log"
        _error "${_container_name} $(_translate i18n_ERROR_DOCKER_CONTAINER_START_LOOP) $_main_dir/logs/docker_compose_restart_loop_${_container_name}_$_date.log"
      elif [ "$_status" == "paused" ] || [ "$_status" == "created" ] || [ "$_status" == "exited" ] || [ "$_status" == "dead" ]; then
        __docker_compose_up "${_container_name}" -d
      fi
    fi

    _status=0
    if [ "$(docker container inspect -f '{{.State.Health.Status}}' "${_container_name}")" == "healthy" ]; then
      _status=1
      _debug "${_container_name} $(_translate i18n_DEBUG_CONTAINER_HEALTHY)"
    else
      sleep 1s
    fi
  done
}

function _check_docker_installation() {
  __set_current_script_docker

  _debug "$(_translate i18n_DEBUG_CHECKING_ALL_CONTAINER_UP)"
  __check_docker_container "${NGINX_CONTAINER_NAME}"
  __check_docker_container "${CERTBOT_CONTAINER_NAME}"
  _debug "$(_translate i18n_DEBUG_ALL_CONTAINER_UP)"
}
