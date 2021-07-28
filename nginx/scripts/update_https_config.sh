#!/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

. "$_scripts_dir/utils.sh"

. "$_scripts_dir/common/i18n_core.sh"
_init_i18n

if ! [ -f "/usr/local/share/exchange/actions/update.action" ]; then
  _error "$(_translate i18n_ERROR_FILE_NOT_EXISTS "/usr/local/share/exchange/actions/update.action")"
fi

_action=$(cat "/usr/local/share/exchange/actions/update.action")
_certificate=$(echo "$_action" | cut -d "/" -f1)
_domains_count=$(echo "$_action" | grep -o "/" | wc -l)
_domains=$(echo "$_action" | cut -d "/" -f2-"$((_domains_count + 1))" | sed "s|/| |g")

sed -i "s/server_name .*/server_name $_domains;/g" "/etc/nginx/conf.d/$_certificate.conf"

nginx -s reload

exit 0
