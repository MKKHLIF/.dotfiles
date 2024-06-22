#!/bin/bash

# Ensure the script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

# Update package list and install required packages
echo "Updating package list and installing required packages..."
sudo pacman -Sy --noconfirm grub

# Create a directory for GRUB themes if it doesn't exist
THEME_DIR="/boot/grub/themes"
if [ ! -d "$THEME_DIR" ]; then
  echo "Creating theme directory..."
  mkdir -p "$THEME_DIR"
fi

# Download and install a popular GRUB theme (e.g., Vimix theme)
THEME_NAME="vimix"
THEME_REPO="https://github.com/vinceliuice/grub2-themes"
echo "Cloning GRUB themes repository..."
git clone "$THEME_REPO" /tmp/grub2-themes

echo "Installing $THEME_NAME theme..."
cd /tmp/grub2-themes
./install.sh -t $THEME_NAME -d $THEME_DIR

# Update GRUB configuration to use the new theme
GRUB_CFG="/etc/default/grub"
THEME_CFG="GRUB_THEME=\"$THEME_DIR/$THEME_NAME/theme.txt\""

if grep -q "GRUB_THEME=" "$GRUB_CFG"; then
  echo "Updating existing GRUB_THEME in $GRUB_CFG..."
  sed -i "s|^GRUB_THEME=.*|$THEME_CFG|" "$GRUB_CFG"
else
  echo "Adding GRUB_THEME to $GRUB_CFG..."
  echo "$THEME_CFG" >> "$GRUB_CFG"
fi

# Regenerate GRUB configuration
echo "Regenerating GRUB configuration..."
grub-mkconfig -o /boot/grub/grub.cfg

# Clean up
echo "Cleaning up..."
rm -rf /tmp/grub2-themes

echo "GRUB theme setup and customization completed successfully."
