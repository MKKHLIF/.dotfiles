#!/bin/bash

USER_HOME=$(eval echo ~$ACTUAL_USER)

if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sudo -u $ACTUAL_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    chsh -s $(which zsh) $ACTUAL_USER
fi

