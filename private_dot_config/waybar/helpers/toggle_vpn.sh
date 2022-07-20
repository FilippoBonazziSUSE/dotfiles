#! /bin/bash
#
# Toggle the VPN connection ON or OFF

# Provide a VPN name to activate [optional]
# If no VPN name is provided, the first available one will be selected
VPN=$1

ACTIVE=$(nmcli connection show --active | grep "vpn" | sed 's/\s\+/\t/g' | cut -f1)

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
