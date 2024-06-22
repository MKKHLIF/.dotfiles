#!/bin/bash

# Ensure the script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

# Update system and install common development tools
echo "Updating package list and installing common development tools..."
sudo pacman -Sy --noconfirm git base-devel neovim

# Install C and C++ development tools
echo "Installing C and C++ development tools..."
sudo pacman -Sy --noconfirm gcc clang cmake gdb

# Install Java development tools
echo "Installing Java development tools..."
sudo pacman -Sy --noconfirm jdk-openjdk openjdk-doc openjdk-src

# Install Python development tools
echo "Installing Python development tools..."
sudo pacman -Sy --noconfirm python python-pip ipython

# Install JavaScript development tools
echo "Installing JavaScript development tools..."
sudo pacman -Sy --noconfirm nodejs npm yarn

# Install additional useful development tools
echo "Installing additional useful development tools..."
sudo pacman -Sy --noconfirm docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

echo "Development environment setup completed successfully."
