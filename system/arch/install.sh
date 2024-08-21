#!/bin/bash

scripts_dir=$HOME/.dotfiles/system/arch/scripts

cd $scripts_dir

message() {
    echo -e "\e[1m\e[32m$1\e[0m"
}

./welcome.sh
message "Setting Git Identity..."
./git_identity.sh
message "Setting AUR Helpers..."
./aur_helpers.sh
message "Creating Config Symlinks..."
./configs_symlinks.sh
message "Installing Packages..."
./install_pkgs.sh