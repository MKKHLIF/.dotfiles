#!/bin/bash

# Update system and install common development tools
echo "Updating package list and installing common development tools..."
sudo pacman -Sy --noconfirm git base-devel neovim


# Install development tools
echo "Installing common tools & packages..."

while read package; do
    yay -S --noconfirm --needed $package
done < ../packages/common_packages.list

echo "common tools & packages installed successfully."


# Install development tools
echo "Installing development tools & packages..."

while read package; do
    yay -S --noconfirm --needed $package
done < ../packages/dev_packages.list

echo "development tools & packages installed successfully."
