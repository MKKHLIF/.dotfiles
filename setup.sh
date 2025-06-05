#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

GITHUB_USER="MKKHLIF"
REPO_NAME=".dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

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
    zypper --non-interactive install git
    if [ $? -ne 0 ]; then
        print_error "Failed to install git!"
        exit 1
    fi
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

cd "$DOTFILES_DIR" || exit

# Check if install script exists and is executable
if [ -f "./opensuse.sh" ]; then
    chmod +x ./opensuse.sh
    sudo ./opensuse.sh
else
    print_error "script not found"
    exit 1
fi



############# REBOOT #################

RED='\033[0;31m'
NC='\033[0m'

echo -e "${RED}Reboot Now? (y/n)${NC}"
read -r REBOOT_CHOICE

if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
    echo "Rebooting..."
    sudo reboot
else
    echo "Reboot canceled."
fi