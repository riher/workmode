#!/bin/bash

sitelist="${XDG_CONFIG_HOME:-$HOME/.config}/workmode/sitelist"

if [[ ! -f "$sitelist" ]]; then
  echo "You don't have configured any sites!"
  exit 1
fi

if [[ "$1" == "activate" ]]; then
  sudo cp /etc/hosts /etc/hosts.nowork
  while read site; do
    echo "127.0.0.1 $site" | sudo tee -a /etc/hosts > /dev/null
  done < "$sitelist"
  echo "Activated workmode! Maximum productivity to you!"
elif [[ "$1" == "deactivate" ]]; then
  if [[ -f "/etc/hosts.nowork" ]]; then
    sudo mv /etc/hosts.nowork /etc/hosts
    echo "Deactivated workmode! Now go play!"
  else
    echo "You aren't in workmode. Thank god!"
  fi
else
  echo "activate or deactivate"
fi
