#!/bin/bash

# Ensure script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Refresh top 10 mirrors by rate
echo "Refreshing top 10 mirrors by download rate..."
reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
echo "Mirrorlist updated successfully"

# Configure pacman to run in parallel with 5 packages at the same time
# echo "Configuring pacman to run in parallel with 5 packages at the same time..."
# PACMAN_CONF="/etc/pacman.conf"
# if ! grep -q "^ParallelDownloads" "$PACMAN_CONF"; then
#     echo "ParallelDownloads = 5" >> "$PACMAN_CONF"
# else
#     sed -i 's/^ParallelDownloads.*/ParallelDownloads = 5/' "$PACMAN_CONF"
# fi

# echo "pacman configured for parallel downloads."

# Update package database and upgrade system
echo "Updating package database and upgrading system..."
pacman -Syu --noconfirm

echo "Post-installation setup complete."
