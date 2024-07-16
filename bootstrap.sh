#!/bin/bash

echo " __  __ ____  _______     _______ _    _ _______ ______ "
echo "|  \/  |  _ \| ____\ \   / / ____| |  | |__   __|  ____|"
echo "| \  / | |_) |  _|  \ \_/ /|  _| | |  | |  | |  | |__   "
echo "| |\/| |  _ <| |___  \   / | |___| |__| |  | |  |  __|  "
echo "| |  | | |_) |_____|  | |  |_____|____/|  |_|  |_|     "
echo "|_|  |_|____/|_____|  |_|  (C) MK DOTFILES INSTALLATION"
echo "========================================================"

echo "Are you on Arch or OpenSUSE? (Type 'arch' or 'opensuse'):"
read os_choice

case $os_choice in
  arch)
    echo "Running installation for Arch..."
    ./scripts/arch/install_arch.sh
    ;;
  opensuse)
    echo "Running installation for OpenSUSE..."
    ./scripts/opensuse/install_opensuse.sh
    ;;
  *)
    echo "Invalid option. Please run the script again and choose either 'arch' or 'opensuse'."
    ;;
esac

echo "Are you on Arch or OpenSUSE? (Type 'dwm' or 'hyprland' or 'both'):"
read dm_choice

case $dm_choice in
  dwm)
    echo "Setting up DWM..."
    ./scripts/display_manager/dwm_setup.sh
    ;;
  hyprland)
    echo "Setting up Hyprland..."
    ./scripts/display_manager/hyprland_setup.sh
    ;;
  both)
    echo "Setting up both DWM and Hyprland..."
    ./scripts/display_manager/dwm_setup.sh
    ./scripts/display_manager/hyprland_setup.sh
    ;;
  *)
    echo "Invalid option. Please run the script again and choose either 'arch' or 'opensuse'."
    ;;
esac

echo "Additional setup..."
./scripts/additional_setup.sh

echo "Setup complete. Please reboot your system to apply changes."