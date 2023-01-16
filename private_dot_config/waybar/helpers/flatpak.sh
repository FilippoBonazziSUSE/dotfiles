#!/bin/bash
# Report the number of available flatpak updates in i3blocks style

num_updates=$(flatpak remote-ls --updates -all | tail -n +2 | wc -l)

if [[ "$num_updates" -eq "0" ]]
then
  exit 1
else
  echo -e "$num_updates\n$num_updates flatpaks to update"
  exit 0
fi
