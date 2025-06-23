#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

echo -e "\e[1;32m"
echo "     _             _       _     _                  "
echo "    / \   _ __ ___| |__   | |   (_)_ __  _   ___  __"
echo "   / _ \ | '__/ __| '_ \  | |   | | '_ \| | | \ \/ /"
echo "  / ___ \| | | (__| | | | | |___| | | | | |_| |>  < "
echo " /_/   \_\_|  \___|_| |_| |_____|_|_| |_|\__,_/_/\_\\"
echo -e "\e[0m"



sudo source ./refresh_mirrors.sh
sudo source ./git_setup.sh
sudo source ./aur_helpers.sh
sudo source ./flatpak.sh
sudo source ./packages.sh

sudo source ./services.sh
sudo source ./groups.sh

sudo source ./symlinks.sh

sudo source ./zsh_setup.sh
sudo source ./grub_setup.sh
sudo source ./sddm.sh



