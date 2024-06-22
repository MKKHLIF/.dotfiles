#!/bin/bash

######## Enhanced dwm & st Setup ########

# Update system and install essential packages
sudo pacman -Sy git base-devel neovim dmenu

# Install Xorg and related packages
sudo pacman -Sy xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk

# Clone dwm and st repositories
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st

# Create .xinitrc to start dwm
echo "xrandr --output HDMI-1 --mode 1920x1080 --rate 120" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc

# Install st (Simple Terminal)
cd st
sudo make clean install
cd ..

# Configure and install dwm (Dynamic Window Manager)
cd dwm
sudo nvim config.h  # Make necessary configurations
# For example, set terminal to st:
# static const char *termcmd[]  = { "st", NULL };
sudo make clean install
cd ..

# Create .bash_profile to start Xorg session with startx
echo "exec startx" > ~/.bash_profile

# Exit script
exit
