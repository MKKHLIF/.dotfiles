#!/bin/bash


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

