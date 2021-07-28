#!/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

. "$_scripts_dir/utils.sh"

. "$_scripts_dir/common/i18n_core.sh"
_init_i18n

if ! [ -f "/usr/local/share/exchange/actions/revoke.action" ]; then
  _error "$(_translate i18n_ERROR_FILE_NOT_EXISTS "/usr/local/share/exchange/actions/revoke.action")"
fi

_action=$(cat "/usr/local/share/exchange/actions/revoke.action")
_certificate=$(echo "$_action" | cut -d "/" -f1)

mv "/etc/nginx/conf.d/$_certificate.conf" "/etc/nginx/conf.d/archive/$_certificate-$(date '+%Y-%m-%d %H:%M:%S').conf.archive"

nginx -s reload

exit 0
