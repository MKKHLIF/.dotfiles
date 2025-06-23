#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

services=(docker libvirtd NetworkManager bluetooth)

for service in "${services[@]}"; do
    systemctl enable --now $service
done

