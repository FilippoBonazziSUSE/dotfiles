#!/bin/bash
# Report the number of available fwupd updates in i3blocks style

set -uo pipefail

fwupdmgr refresh &>/dev/null
fwupdmgr get-updates &>/dev/null

if [[ "$?" -eq "0" ]]
then
  echo -e "\nFirmware updates available"
  exit 0
else
  echo -e "\nNo firmware updates available"
  exit 1
fi
