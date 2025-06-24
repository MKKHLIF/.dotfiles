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

SCRIPT_DIR="/home/mk/.dotfiles/scripts/arch"

print_section() {
  echo -e "\n\e[1;35m========== $1 ==========\e[0m"
}

print_section "Refreshing Mirrors"
echo -e "${GREEN}Do you want to refresh Arch mirrors before proceeding? (y/n)${NC}"
read -r MIRROR_CHOICE
if [[ "$MIRROR_CHOICE" =~ ^[Yy]$ ]]; then
    if [ -x "$SCRIPT_DIR/refresh_mirrors.sh" ]; then
        "$SCRIPT_DIR/refresh_mirrors.sh"
    else
        print_error "refresh_mirrors.sh not found or not executable."
    fi
fi


print_section "Git Setup"
"$SCRIPT_DIR/git_setup.sh"

print_section "Installing AUR Helpers"
"$SCRIPT_DIR/aur_helpers.sh"

print_section "Installing Flatpak Packages"
"$SCRIPT_DIR/flatpak.sh"

print_section "Installing Core Packages"
"$SCRIPT_DIR/packages.sh"

print_section "Enabling Services"
"$SCRIPT_DIR/services.sh"

print_section "Creating User Groups"
"$SCRIPT_DIR/groups.sh"

print_section "Creating Symlinks"
"$SCRIPT_DIR/symlinks.sh"

print_section "Setting Up ZSH"
"$SCRIPT_DIR/zsh_setup.sh"

print_section "Setting Up GRUB"
"$SCRIPT_DIR/grub_setup.sh"

print_section "Configuring SDDM Theme"
"$SCRIPT_DIR/sddm.sh"

