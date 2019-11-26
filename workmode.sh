#!/bin/bash

sitelist="${XDG_CONFIG_HOME:-$HOME/.config}/workmode/sitelist"

if [[ ! -f "$sitelist" ]]; then
  echo "You don't have configured any sites!"
  exit 1
fi

if [[ "$1" == "activate" ]]; then
  while read site; do
    echo "address=/$site/" | sudo tee -a /etc/dnsmasq.d/workmode > /dev/null
  done < "$sitelist"
  sudo systemctl restart dnsmasq.service
  echo "Activated workmode! Maximum productivity to you!"
elif [[ "$1" == "deactivate" ]]; then
  if [[ -f "/etc/dnsmasq.d/workmode" ]]; then
    sudo rm /etc/dnsmasq.d/workmode
    sudo systemctl restart dnsmasq.service
    echo "Deactivated workmode! Now go play!"
  else
    echo "You aren't in workmode. Thank god!"
  fi
else
  echo "activate or deactivate"
fi
