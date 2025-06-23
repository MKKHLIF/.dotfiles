#!/bin/bash

# Install AUR helper
install_aur_helper() {
    local helper_name=$1
    local helper_url=$2
    local ACTUAL_USER=$3
    
    if ! command -v $helper_name &> /dev/null; then
        echo "Installing $helper_name..."
        cd /tmp
        sudo -u $ACTUAL_USER git clone $helper_url
        cd $helper_name
        sudo -u $ACTUAL_USER makepkg -si --noconfirm
        cd ..
        rm -rf $helper_name
    else
        echo "$helper_name is already installed."
    fi
}

# Install AUR helpers (paru and yay)
install_aur_helper "paru" "https://aur.archlinux.org/paru.git" "$ACTUAL_USER"
install_aur_helper "yay" "https://aur.archlinux.org/yay.git" "$ACTUAL_USER"

