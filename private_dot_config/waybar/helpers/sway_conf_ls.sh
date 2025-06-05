#!/bin/bash
#
# Find all files in the Sway configuration

set -euo pipefail

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

MAX_NESTED_INCLUDES=99
include_level=0

sway_config_files=(
  "$HOME/.sway/config"
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
      include_level=$((include_level + 1))

      # Follow the include chain
      while read -r l
      do
        # Expand ~ to $HOME manually
        l="${l/#\~/$HOME}"

        # Expand globs if any
        while read -r f
        do
          parse_conf_file "$f"
        done < <(compgen -o filenames -G "$l" | sort)
      done < <(grep -oP "(?<=include )[^#]+$" "$f")

      include_level=$((include_level - 1))
    fi
  fi
}

for f in "${sway_config_files[@]}"
do
  parse_conf_file "$f"
done
