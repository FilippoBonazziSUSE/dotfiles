#!/bin/bash
#
# Toggle the VPN connection ON or OFF

# Provide a VPN name to activate [optional]
# If no VPN name is provided, the first available one will be selected

set -euo pipefail

VPN=$1

ACTIVE=$(nmcli connection show --active | grep "vpn" | awk 'NR==1 {print $1}')

if [ -z "$ACTIVE" ]
then
  if [ -z "$VPN" ]
  then
    expect ~/.config/waybar/helpers/vpn.exp
  else
    expect ~/.config/waybar/helpers/vpn.exp "$VPN"
  fi
else
  nmcli con down id "$ACTIVE"
fi
