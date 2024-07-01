#!/bin/bash

# Variables
CONFIG_DIR="$HOME/.config"
GIT_DIR="$HOME/dotfiles"

# Create configuration directories
mkdir -p "$CONFIG_DIR/kitty"
mkdir -p "$CONFIG_DIR/wofi"
mkdir -p "$CONFIG_DIR/hypr"
mkdir -p "$CONFIG_DIR/hyprpaper"

# Link configuration files
ln -sf "$GIT_DIR/configs/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"
# ln -sf "../../configs/wofi/config" "$CONFIG_DIR/wofi/config"
# ln -sf "../../configs/wofi/style.css" "$CONFIG_DIR/wofi/style.css"
ln -sf "$GIT_DIR/configs/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
ln -sf "$GIT_DIR/configs/hyprpaper.conf" "$CONFIG_DIR/hyprpaper/hyprpaper.conf"
