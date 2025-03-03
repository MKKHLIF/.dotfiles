#!/bin/bash

# Configuration
GITHUB_USER="MKKHLIF"
REPO_NAME="dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}==>${NC} $1"
}

print_error() {
    echo -e "${RED}==>${NC} $1"
}

# Check if running as root and re-run with sudo if needed
if [ "$(id -u)" != "0" ] && ! command -v git >/dev/null 2>&1; then
    print_status "Git is not installed. Requesting sudo privileges to install it..."
    exec sudo "$0" "$@"
fi

if ! command -v git >/dev/null 2>&1; then
    print_status "Installing git using zypper..."
    zypper --non-interactive install git
    
    if [ $? -ne 0 ]; then
        print_error "Failed to install git"
        exit 1
    fi
    print_status "Git installed successfully"
fi

# Remove existing dotfiles directory if it exists
if [ -d "$DOTFILES_DIR" ]; then
    print_status "Existing dotfiles directory found. Removing..."
    rm -rf "$DOTFILES_DIR"
    
    if [ $? -ne 0 ]; then
        print_error "Failed to remove existing dotfiles directory"
        exit 1
    fi
    print_status "Existing dotfiles directory removed successfully"
fi

# Clone the repository
print_status "Cloning dotfiles repository..."
git clone "https://github.com/$GITHUB_USER/$REPO_NAME.git" "$DOTFILES_DIR"

if [ $? -ne 0 ]; then
    print_error "Failed to clone repository"
    exit 1
fi

# Change to the dotfiles directory
cd "$DOTFILES_DIR" || exit

# Check if install script exists and is executable
if [ -f "./install.sh" ]; then
    print_status "Running install script..."
    chmod +x ./install.sh
    ./install.sh
else
    print_error "Install script not found"
    exit 1
fi

print_status "Dotfiles setup completed successfully!"
