#!/bin/bash

# Ensure script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi


# Packages to install
PACKAGES=(
    "sddm"
    "dolphin"
    "kitty"
    "wofi"
    "hyprland"
    "hyprpaper"
    "waybar"
    "wayland"
    "xorg-xwayland"
    "xdg-desktop-portal-hyprland"
    "wl-clipboard"
)

# Install packages
for package in "${PACKAGES[@]}"; do
    yay -S --needed --noconfirm --noredownload "$package"
done


echo "Setting configuration files..."
bash ./CONFIG_FILES.sh

echo "Setting wlsunset..."
bash ./wlsunset_setup.sh

echo "Setting SDDM..."
bash ./SDDM_SETUP.sh