#!/bin/bash
#
# Find all files in the Sway configuration

set -euo pipefail

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

MAX_NESTED_INCLUDES=99
include_level=0

sway_config_files=(
  "~/.sway/config"
  "$XDG_CONFIG_HOME/sway/config"
  "/etc/sway/config"
)


parse_conf_file() {
  if [ -f "$1" ]
  then
    readlink -f "$1"

    if [ $include_level -ge $MAX_NESTED_INCLUDES ]
    then
      >&2 echo "Too many nested includes (stopping at $MAX_NESTED_INCLUDES). Bad config?"
    else
      ((include_level++))

      # Follow the include chain
      while read -r l
      do
        # Expand ~ to $HOME manually
        l="${l/#\~/$HOME}"

        # Expand globs if any
        if [[ "$l" =~ '*' ]]
        then
          # Split the path into pre and post star
          confpath=${l%\**}
          confext=${l#*\*}

          for f in "${confpath}"/*"${confext}"
          do
            parse_conf_file "$f"
          done
        else
          parse_conf_file "$l"
        fi
      done <<< $(grep -oP "(?<=include )[^#]+$" "$f")
      ((include_level--))
    fi
  fi
}

for f in "${sway_config_files[@]}"
do
  parse_conf_file "$f"
done
