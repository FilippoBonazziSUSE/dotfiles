#!/bin/bash
# Report the number of available NPM updates in i3blocks style

set -euo pipefail

num_updates=$(npm outdated -g | tail -n +2 | wc -l)

if [[ "$num_updates" -eq "0" ]]
then
  exit 1
else
  echo -e "$num_updates\n$num_updates packages to update"
  exit 0
fi
