#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

services=(docker libvirtd NetworkManager bluetooth)

for service in "${services[@]}"; do
    if systemctl is-enabled --quiet "$service" && systemctl is-active --quiet "$service"; then
        echo -e "\e[34mAlready active:\e[0m $service"
    else
        systemctl enable --now "$service"
        echo -e "\e[34mActivated:\e[0m $service"
    fi
done

