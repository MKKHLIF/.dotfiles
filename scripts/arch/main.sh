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

print_section() {
  echo -e "\n\e[1;35m========== $1 ==========\e[0m"
}

print_section "Refreshing Mirrors"
./refresh_mirrors.sh

print_section "Git Setup"
./git_setup.sh

print_section "Installing AUR Helpers"
./aur_helpers.sh

print_section "Installing Flatpak Packages"
./flatpak.sh

print_section "Installing Core Packages"
./packages.sh

print_section "Enabling Services"
./services.sh

print_section "Creating User Groups"
./groups.sh

print_section "Creating Symlinks"
./symlinks.sh

print_section "Setting Up ZSH"
./zsh_setup.sh

print_section "Setting Up GRUB"
./grub_setup.sh

print_section "Configuring SDDM Theme"
./sddm.sh
