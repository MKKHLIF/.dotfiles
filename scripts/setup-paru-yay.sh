#!/bin/bash

# Update package list and install essential tools
echo "Updating package list and installing essential tools..."
sudo pacman -Sy --noconfirm git base-devel

# Install Paru AUR helper
echo "Installing Paru AUR helper..."
cd /tmp
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si --noconfirm

# Install Yay AUR helper
echo "Installing Yay AUR helper..."
cd /tmp
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm

# Clean up temporary files
echo "Cleaning up temporary files..."
rm -rf /tmp/paru-bin
rm -rf /tmp/yay-bin

echo "Paru and Yay installation completed successfully."
