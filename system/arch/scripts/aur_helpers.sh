#!/bin/bash

# Check if Git is installed, if not, install it
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Installing Git..."
    sudo pacman -S --noconfirm git
    echo "Git installed successfully."
fi

# Install Yay
echo "Installing Yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
echo "Yay installed successfully."

# Install Paru
echo "Installing Paru..."
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru
echo "Paru installed successfully."

# Clean up
echo "Cleaning up..."
sudo pacman -Scc --noconfirm
echo "Cleanup completed."

echo "Yay and Paru have been set up successfully."
