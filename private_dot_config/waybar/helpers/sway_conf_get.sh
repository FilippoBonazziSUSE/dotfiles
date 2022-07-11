#!/bin/bash
#
# Get the value of a variable in the Sway configuration

bash "$(dirname $0)/sway_conf_ls.sh" | tac | xargs tac | grep -e "^\s*set" | grep -h -oP "(?<=$1\ )\"[^\"]+\""
