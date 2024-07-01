#!/bin/bash

# Function to install packages from a given list file
install_packages() {
    local file=$1
    local description=$2
    
    if [[ -f $file ]]; then
        echo "Installing $description..."
        while read -r package; do
            yay -S --noconfirm --needed "$package"
        done < "$file"
        echo "$description installed successfully."
    else
        echo "Error: $file not found. Exiting."
        exit 1
    fi
}

# Get the current script directory
SCRIPT_DIR=$(dirname "$0")

# Update system and install common development tools
echo "Updating package list and installing common development tools..."
sudo pacman -Sy --noconfirm git base-devel neovim

# Install system packages
install_packages "$SCRIPT_DIR/../packages/system_packages.list" "system packages"

# Install common tools & packages
install_packages "$SCRIPT_DIR/../packages/common_packages.list" "common tools & packages"

# Install development tools & packages
install_packages "$SCRIPT_DIR/../packages/dev_packages.list" "development tools & packages"
