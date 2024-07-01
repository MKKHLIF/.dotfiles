#!/bin/bash

# Ensure script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Variables
SCRIPT_DIR=$(dirname "$(realpath "$0")")
CONFIG_DIR="$HOME/.config"

# Packages to install
PACKAGES=(
    "sddm"
    "kitty"
    "wofi"
    "hyprland"
    "hyprpaper"
    "wayland"
    "xorg-xwayland"
    "xdg-desktop-portal-hyprland"
    "wl-clipboard"
)

# Install packages
for package in "${PACKAGES[@]}"; do
    yay -S --needed --noconfirm --noredownload "$package"
done

# Stop and disable other display managers
DISPLAY_MANAGERS=(
    "gdm.service"
    "lightdm.service"
    "lxdm.service"
)

for dm in "${DISPLAY_MANAGERS[@]}"; do
    systemctl stop "$dm" 2>/dev/null
    systemctl disable "$dm" 2>/dev/null
done

# Enable and start SDDM service
systemctl enable sddm.service
systemctl start sddm.service

# Create configuration directories
mkdir -p "$CONFIG_DIR/kitty"
mkdir -p "$CONFIG_DIR/wofi"
mkdir -p "$CONFIG_DIR/hypr"
mkdir -p "$CONFIG_DIR/hyprpaper"

# Link configuration files
ln -sf "$SCRIPT_DIR/configs/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"
ln -sf "$SCRIPT_DIR/configs/wofi/config" "$CONFIG_DIR/wofi/config"
ln -sf "$SCRIPT_DIR/configs/wofi/style.css" "$CONFIG_DIR/wofi/style.css"
ln -sf "$SCRIPT_DIR/configs/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
ln -sf "$SCRIPT_DIR/configs/hyprpaper.conf" "$CONFIG_DIR/hyprpaper/hyprpaper.conf"

# SDDM configuration for Hyprland
SDDM_CONFIG="/usr/share/wayland-sessions/hyprland.desktop"
cat <<EOL > "$SDDM_CONFIG"
[Desktop Entry]
Name=Hyprland
Comment=An advanced, customizable Wayland compositor
Exec=Hyprland
Type=Application
EOL

echo "Setup complete. Please reboot your system to apply changes."
