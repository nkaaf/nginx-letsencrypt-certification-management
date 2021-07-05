#!/usr/bin/env bash

. "$_scripts_dir/common/common.sh"
_init_script "$0"

_check_value_is_set "USER_EMAIL"
_check_value_is_set "CERTBOT_WEBROOT"

sed -i "s|{{USER_EMAIL}}|${USER_EMAIL}|g" "/etc/letsencrypt/cli.ini"
sed -i "s|{{CERTBOT_WEBROOT}}|${CERTBOT_WEBROOT}|g" "/etc/letsencrypt/cli.ini"

exit 0
