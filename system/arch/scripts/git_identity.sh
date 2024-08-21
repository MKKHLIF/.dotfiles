#!/bin/bash

# Check if Git is installed, if not, install it
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Installing Git..."
    sudo pacman -S --noconfirm git
    echo "Git installed successfully."
fi

# Prompt the user for name and email
read -p "Enter your name: " name
read -p "Enter your email: " email

# Set Git identity
git config --global user.name "$name"
git config --global user.email "$email"
echo "Git identity set to: $name ($email)."

# Generate Ed25519 SSH key pair
ssh_dir="$HOME/.ssh"
ssh_private_key="$ssh_dir/id_ed25519"
ssh_public_key="$ssh_dir/id_ed25519.pub"

# Create .ssh directory if it doesn't exist
if [ ! -d "$ssh_dir" ]; then
    mkdir -p "$ssh_dir"
    chmod 700 "$ssh_dir"
fi

# Check if the SSH key files already exist
if [ -f "$ssh_private_key" ] || [ -f "$ssh_public_key" ]; then
    read -p "SSH key pair already exists. Do you want to overwrite it? (y/n) " overwrite
    if [ "$overwrite" != "y" ]; then
        echo "SSH key generation aborted."
        exit 1
    fi
fi

# Generate the Ed25519 SSH key pair
ssh-keygen -t ed25519 -C "$email" -f "$ssh_private_key" -N ""
echo "SSH key pair generated:"
echo "Public key: $ssh_public_key"