#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

USER_HOME="/home/mk"
ACTUAL_USER="mk"

if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sudo -u $ACTUAL_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    chsh -s $(which zsh) $ACTUAL_USER
else
    echo "Oh My Zsh is already installed at $USER_HOME/.oh-my-zsh"
fi

