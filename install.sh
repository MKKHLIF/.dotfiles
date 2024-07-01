#!/bin/bash

echo "Starting the setup process..."

# post installation setup
echo "post installation setup..."
bash ./scripts/POST_INSTALL.sh

# Aur helpers 
echo "Setting AUR helpers..."
bash ./scripts/AUR_SETUP.sh

# NVIDIA drivers
echo "Setting NVIDIA drivers..."
bash ./scripts/NVIDIA_SETUP.sh

# global git identity
echo "Setting global git identity..."
bash ./scripts/GIT_SETUP.sh

# personal packages and tools
echo "Installing personal packages and tools..."
bash ./scripts/PKG_SETUP.sh

# systemd services
echo "Activating systemd services..."
bash ./scripts/SYS_SETUP.sh

# Hyprland setup
echo "Setting Hyprland..."
bash ./scripts/Hyprland/HYP_SETUP.sh


echo "Setup process completed successfully!"