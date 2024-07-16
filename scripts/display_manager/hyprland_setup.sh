#!/bin/bash

# ============================== PACKAGES ===================================
PACKAGES=(
    "sddm"
    "dolphin"
    "kitty"
    "wofi"
    "hyprland"
    "hyprpaper"
    "waybar"
    "wayland"
    "xorg-xwayland"
    "xdg-desktop-portal-hyprland"
    "wl-clipboard"
)

for package in "${PACKAGES[@]}"; do
    yay -S --needed --noconfirm --noredownload "$package"
done
# ============================== CONFIG FILES =================================== 
CONFIG_DIR="$HOME/.config"
GIT_DIR="$HOME/dotfiles"

rm -rf "$CONFIG_DIR/kitty"
rm -rf "$CONFIG_DIR/wofi"
rm -rf "$CONFIG_DIR/hypr"
rm -rf "$CONFIG_DIR/hyprpaper"
rm -rf "$CONFIG_DIR/gammastep"
rm -rf "$CONFIG_DIR/nvim"
rm -rf "$CONFIG_DIR/waybar"

mkdir -p "$CONFIG_DIR/kitty"
mkdir -p "$CONFIG_DIR/wofi"
mkdir -p "$CONFIG_DIR/hypr"
mkdir -p "$CONFIG_DIR/hyprpaper"
mkdir -p "$CONFIG_DIR/gammastep"
mkdir -p "$CONFIG_DIR/nvim"
mkdir -p "$CONFIG_DIR/waybar"

ln -sf "$GIT_DIR/configs/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"
# ln -sf "$GIT_DIR/configs/wofi/config" "$CONFIG_DIR/wofi/config"
# ln -sf "$GIT_DIR/configs/wofi/style.css" "$CONFIG_DIR/wofi/style.css"
ln -sf "$GIT_DIR/configs/waybar/config.jsonc" "$CONFIG_DIR/waybar/config.jsonc"
ln -sf "$GIT_DIR/configs/waybar/style.css" "$CONFIG_DIR/waybar/style.css"
ln -sf "$GIT_DIR/configs/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
ln -sf "$GIT_DIR/configs/hyprpaper/hyprpaper.conf" "$CONFIG_DIR/hyprpaper/hyprpaper.conf"
ln -sf "$GIT_DIR/configs/hyprpaper/wallpapers" "$CONFIG_DIR/hyprpaper/wallpapers"
ln -sf "$GIT_DIR/configs/nvim/init.lua" "$CONFIG_DIR/nvim/init.lua"

# ============================== SDDM SETUP =================================== 
SDDM_CONFIG="/usr/share/wayland-sessions/hyprland.desktop"
cat <<EOL > "$SDDM_CONFIG"
[Desktop Entry]
Name=Hyprland
Comment=An advanced, customizable Wayland compositor
Exec=Hyprland
Type=Application
EOL

echo "Setup complete. Please reboot your system to apply changes."

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

systemctl enable sddm.service
systemctl start sddm.service
# ============================== SDDM SETUP =================================== 

