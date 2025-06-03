#!/bin/bash
# Report the number of available zypper updates in i3blocks style

set -euo pipefail

num_updates=$(zypper -n lu | grep -c 'v \+|')

if [[ "$num_updates" -eq "0" ]]
then
  exit 1
else
  echo -e "$num_updates\n$num_updates packages to update"
  exit 0
fi
