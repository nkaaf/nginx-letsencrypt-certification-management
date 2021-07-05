#!/usr/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

. "$_scripts_dir/utils.sh"

_check_value_is_set "CERTBOT_WEBROOT"
_check_value_is_set "HTTP_PORT"

sed -i "s|{{CERTBOT_WEBROOT}}|${CERTBOT_WEBROOT}|g" "/etc/nginx/certbot.conf"
sed -i "s|{{HTTP_PORT}}|${HTTP_PORT}|g" "/etc/nginx/certbot.conf"

exit 0
