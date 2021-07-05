#!/usr/bin/env bash

function _collect_data() {
  local _data

  _data="\tThis Project Version: $(cat "/usr/local/share/exchange/version")\n"

  _data="${_data}\t$(nginx -version)\n"

  echo "$_data"
}
