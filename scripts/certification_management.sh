#!/usr/bin/env bash

function __set_current_script_certification_management() {
  _init_script "$0"
}

function _certbot_menu() {
  local _answer

  while :; do
    __set_current_script_certification_management
    echo -e "\n$(_translate i18n_HEADLINE_CERTIFICATION_MENU)"
    echo "1. $(_translate i18n_OPTION_SHOW_ALL_CERTIFICATES)"
    echo "2. $(_translate i18n_OPTION_SHOW_SPECIFIC_CERTIFICATE)"
    echo "3. $(_translate i18n_OPTION_CREATE_CERTIFICATE)"
    echo "4. $(_translate i18n_OPTION_REVOKE_CERTIFICATE)"
    echo "5. $(_translate i18n_OPTION_UPDATE_CERTIFICATE)"
    echo "6. $(_translate i18n_OPTION_SHOW_HISTORY)"
    echo "7. $(_translate i18n_OPTION_EXIT_CERTIFICATION_MENU)"
    echo "$(_translate i18n_ENTER_NUMBER_MENU "[1-7]")"
    read -r _answer
    echo "----------"

    case $_answer in
      1)
        docker exec "${CERTBOT_CONTAINER_NAME}" bash show_certificates.sh "${LANGUAGE}" 0
        ;;
      2)
        docker exec -it "${CERTBOT_CONTAINER_NAME}" bash show_certificates.sh "${LANGUAGE}" 1
        ;;
      3)
        if docker exec -it "${CERTBOT_CONTAINER_NAME}" bash get_certificate.sh "${LANGUAGE}"; then
          docker exec "${NGINX_CONTAINER_NAME}" bash create_https_config.sh
        fi
        ;;
      4)
        if docker exec -it "${CERTBOT_CONTAINER_NAME}" bash revoke_certificate.sh "${LANGUAGE}"; then
          docker exec "${NGINX_CONTAINER_NAME}" bash archive_https_config.sh
        fi
        ;;
      5)
        if docker exec -it "${CERTBOT_CONTAINER_NAME}" bash update_certificate.sh "${LANGUAGE}"; then
          docker exec "${NGINX_CONTAINER_NAME}" bash update_https_config.sh
        fi
        ;;
      6)
        docker exec -it "${CERTBOT_CONTAINER_NAME}" bash show_history.sh "${LANGUAGE}"
        ;;
      7)
        return 0
        ;;
      *)
        _echo "red" "$(_translate i18n_ERROR_INCORRECT_OPTION)"
        ;;
    esac
  done
}
