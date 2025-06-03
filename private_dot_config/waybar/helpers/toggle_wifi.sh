#!/bin/bash
#
# Toggle the specified WiFi interface

set -euo pipefail

STATUS=$(nmcli radio wifi)

if [ "$STATUS" == "enabled" ]
then
  nmcli radio wifi off
else
  nmcli radio wifi on
fi
