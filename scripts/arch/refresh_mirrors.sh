#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

set -e

# Install reflector if missing
if ! command -v reflector &> /dev/null; then
    echo "Installing reflector..."
    pacman -S --noconfirm reflector
fi

# Define paths
MIRRORLIST="/etc/pacman.d/mirrorlist"
BACKUP="/etc/pacman.d/mirrorlist.backup"

# Backup existing mirrorlist
if [ -f "$BACKUP" ]; then
    echo "Overwriting existing backup..."
else
    echo "Creating mirrorlist backup..."
fi
cp -f "$MIRRORLIST" "$BACKUP"

echo "Refreshing mirrorlist with top 10 mirrors from France and Germany..."
reflector \
    --country France,Germany \
    --age 48 \
    --protocol https \
    --sort rate \
    --download-timeout 10 \
    --save "$MIRRORLIST"

echo "Mirrorlist updated successfully."

echo "Updating package database and syncing system..."
pacman -Syu --noconfirm

