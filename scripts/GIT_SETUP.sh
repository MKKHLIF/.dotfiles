#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing git..."
    sudo pacman -Syu --noconfirm git
else
    echo "Git is already installed."
fi

# Prompt for Git email (used for both SSH key and Git identity)
read -p "Enter your Git email: " git_email

# Generate SSH key with no passphrase using ed25519
echo "Generating SSH key..."
ssh-keygen -t ed25519 -C "$git_email" -N "" -f ~/.ssh/id_ed25519

# Add SSH key to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Prompt for Git username
read -p "Enter your Git username: " git_username

# Configure Git
git config --global user.name "$git_username"
git config --global user.email "$git_email"

echo "Git has been installed and configured with the following details:"
echo "Username: $git_username"
echo "Email: $git_email"
echo "Your SSH key has been generated and added to the ssh-agent."
echo "Public key:"
cat ~/.ssh/id_ed25519.pub
