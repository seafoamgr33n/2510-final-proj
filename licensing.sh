#!/usr/bin/env bash
# Use in the main script:  source ./license_combined.sh && check_license

LICENSE_FILE="${LICENSE_FILE:-/etc/halberd_license.dat}"
OBF_KEY="NjE1MTAyNDIyOTE2Nzk5MQ==" # key is reversed + base64 encoded (not in clear text)

check_license() {
  # License file already exists and matches
  [[ -f "$LICENSE_FILE" && "$(cat "$LICENSE_FILE")" == "$OBF_KEY" ]] && return 0

  # Otherwise ask for the 16-digit key
  read -rp "Enter 16-digit license key: " input
  echo
  if [[ "$(printf '%s' "$input" | rev | base64)" == "$OBF_KEY" ]]; then
    echo "$OBF_KEY" >"$LICENSE_FILE" || {
      echo "Run as root."
      exit 1
    }
    echo "License activated."
  else
    echo "Invalid license key."
    exit 1
  fi
}

# Lets you run this file by itself for testing
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  check_license && echo "License OK - program running"
fi
