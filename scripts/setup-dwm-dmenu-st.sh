#!/bin/bash

# Ensure the script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

# Update system and install essential packages
echo "Updating package list and installing essential packages..."
sudo pacman -Sy --noconfirm git base-devel neovim xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk

# Clone dwm, dmenu, and st repositories
echo "Cloning repositories..."
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st

# Create .xinitrc to start dwm
echo "Creating .xinitrc file..."
echo "xrandr --output HDMI-1 --mode 1920x1080 --rate 120" >> ~/.xinitrc
echo "exec dwm" > ~/.xinitrc

# Install st (Simple Terminal)
echo "Installing st..."
cd st
sudo make clean install
cd ..

# Install dmenu
echo "Installing dmenu..."
cd dmenu
sudo make clean install
cd ..

# Configure and install dwm (Dynamic Window Manager)
echo "Configuring and installing dwm..."
cd dwm
sudo nvim config.h  # Make necessary configurations
# For example, set terminal to st:
# static const char *termcmd[]  = { "st", NULL };
sudo make clean install
cd ..

# Create .bash_profile to start Xorg session with startx
echo "Creating .bash_profile file..."
echo "exec startx" > ~/.bash_profile

echo "dwm, dmenu, and st setup and installation completed successfully."
