#!/bin/bash
# Report the number of running audio sources (microphones) in i3blocks style

num_sources="$(pactl list sources short | grep -c RUNNING)"

if [[ "$num_sources" -eq "0" ]]
then
  exit 1
else
  echo -e "$num_sources\n$num_sources sources running"
  exit 0
fi
