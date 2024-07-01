#!/bin/bash

# Ensure script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi


# Packages to install
PACKAGES=(
    "sddm"
    "kitty"
    "wofi"
    "hyprland"
    "hyprpaper"
    "wayland"
    "xorg-xwayland"
    "xdg-desktop-portal-hyprland"
    "wl-clipboard"
)

# Install packages
for package in "${PACKAGES[@]}"; do
    yay -S --needed --noconfirm --noredownload "$package"
done



