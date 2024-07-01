#!/bin/bash

# Variables
CONFIG_DIR="$HOME/.config"
GIT_DIR="$HOME/dotfiles"

# Remove existing directories if they exist
rm -rf "$CONFIG_DIR/kitty"
rm -rf "$CONFIG_DIR/wofi"
rm -rf "$CONFIG_DIR/hypr"
rm -rf "$CONFIG_DIR/hyprpaper"
rm -rf "$CONFIG_DIR/gammastep"
rm -rf "$CONFIG_DIR/nvim"

# Create configuration directories
mkdir -p "$CONFIG_DIR/kitty"
mkdir -p "$CONFIG_DIR/wofi"
mkdir -p "$CONFIG_DIR/hypr"
mkdir -p "$CONFIG_DIR/hyprpaper"
mkdir -p "$CONFIG_DIR/gammastep"
mkdir -p "$CONFIG_DIR/nvim"

# Link configuration files
ln -sf "$GIT_DIR/configs/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"
# Uncomment the following lines if you have wofi configuration files
# ln -sf "$GIT_DIR/configs/wofi/config" "$CONFIG_DIR/wofi/config"
# ln -sf "$GIT_DIR/configs/wofi/style.css" "$CONFIG_DIR/wofi/style.css"
ln -sf "$GIT_DIR/configs/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
ln -sf "$GIT_DIR/configs/hyprpaper.conf" "$CONFIG_DIR/hyprpaper/hyprpaper.conf"
ln -sf "$GIT_DIR/configs/nvim/init.lua" "$CONFIG_DIR/nvim/init.lua"
