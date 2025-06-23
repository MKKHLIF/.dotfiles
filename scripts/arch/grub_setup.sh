#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

set -e

# Ensure git is available
pacman -S --noconfirm git

# Temporary working directory
THEME_DIR="/tmp/grub2-themes"

# Clone the GRUB theme repo
echo "Cloning GRUB theme repository..."
git clone --depth=1 https://github.com/vinceliuice/grub2-themes.git "$THEME_DIR"

# Install Stylix theme
echo "Installing Stylix GRUB theme..."
cd "$THEME_DIR"
sudo ./install.sh -t stylish
rm -rf "$THEME_DIR"


