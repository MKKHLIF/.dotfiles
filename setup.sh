#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

GITHUB_USER="MKKHLIF"
REPO_NAME=".dotfiles"

ACTUAL_USER="mk"
USER_HOME="/home/$ACTUAL_USER"
DOTFILES_DIR="$USER_HOME/$REPO_NAME"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}==>${NC} $1"
}

print_error() {
    echo -e "${RED}==>${NC} $1"
}

if ! command -v git >/dev/null 2>&1; then
    print_status "Git is not installed. Installing..."
    zypper --non-interactive install git
    if [ $? -ne 0 ]; then
        print_error "Failed to install git!"
        exit 1
    fi
fi

if [ -d "$DOTFILES_DIR" ]; then
    print_status "Removing existing dotfiles directory..."
    rm -rf "$DOTFILES_DIR" || {
        print_error "Failed to remove existing dotfiles directory"
        exit 1
    }
    print_status "Existing dotfiles directory removed"
fi

# Clone the repository
print_status "Cloning dotfiles repository..."
git clone "https://github.com/$GITHUB_USER/$REPO_NAME.git" "$DOTFILES_DIR" || {
    print_error "Failed to clone repository"
    exit 1
}

chown -R "$ACTUAL_USER:$ACTUAL_USER" "$DOTFILES_DIR"

cd "$DOTFILES_DIR" || exit 1

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    if [[ "$ID" == "arch" ]]; then
        print_status "Detected Arch Linux. Running Arch script..."
        if [[ -f "./scripts/arch/main.sh" ]]; then
            chmod +x ./scripts/arch/main.sh
            sudo ACTUAL_USER="$ACTUAL_USER" ./scripts/arch/main.sh
        else
            print_error "Arch script not found!"
            exit 1
        fi
    elif [[ "$ID" == "opensuse" ]]; then
        print_status "Detected openSUSE. Running openSUSE script..."
        if [[ -f "./scripts/opensuse/main.sh" ]]; then
            chmod +x ./scripts/opensuse/main.sh
            sudo ACTUAL_USER="$ACTUAL_USER" ./scripts/opensuse/main.sh
        else
            print_error "openSUSE script not found!"
            exit 1
        fi
    else
        print_error "Unsupported distribution: $ID"
        exit 1
    fi
else
    print_error "/etc/os-release not found"
    exit 1
fi

echo -e "${RED}Reboot Now? (y/n)${NC}"
read -r REBOOT_CHOICE

if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
    echo "Rebooting..."
    reboot
else
    echo "Reboot canceled."
fi
