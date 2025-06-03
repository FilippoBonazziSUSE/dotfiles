#!/bin/bash
# Report the number of available flatpak updates in i3blocks style

# Obtain the number of updates as the number of lines in the command output,
# minus the headings line. If no updates are present, the command output will
# be empty.

set -euo pipefail

num_updates=$(flatpak remote-ls --updates --all | tail -n +1 | wc -l)

if [[ "$num_updates" -eq "0" ]]
then
  exit 1
else
  echo -e "$num_updates\n$num_updates flatpaks to update"
  exit 0
fi
