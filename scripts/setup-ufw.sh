#!/bin/bash

# Ensure the script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

# Update package list and install UFW
echo "Updating package list and installing UFW..."
sudo pacman -Sy --noconfirm ufw

# Reset UFW to default settings
echo "Resetting UFW to default settings..."
ufw reset

# Set default policies: deny incoming, allow outgoing
echo "Setting default policies..."
ufw default deny incoming
ufw default allow outgoing

# Allow incoming SSH (port 22)
echo "Allowing incoming SSH..."
ufw allow 22/tcp

# Allow incoming HTTP (port 80) and HTTPS (port 443)
echo "Allowing incoming HTTP and HTTPS..."
ufw allow 80/tcp
ufw allow 443/tcp

# Allow incoming connections on a specific port, e.g., for a web server or application
# Example: Allow incoming traffic on port 8080
# echo "Allowing incoming traffic on port 8080..."
# ufw allow 8080/tcp

# Enable UFW
echo "Enabling UFW..."
ufw enable

# Display UFW status
echo "UFW status:"
ufw status verbose

echo "UFW setup and configuration completed successfully."
