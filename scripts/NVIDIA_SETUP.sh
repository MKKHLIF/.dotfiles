#!/bin/bash

# Ensure script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Variables
KERNEL_VERSION=$(uname -r)

# Install Nvidia proprietary drivers
pacman -Syu --noconfirm   # Update system first
pacman -S --noconfirm nvidia-dkms nvidia-utils nvidia-settings

# Enable Nvidia Persistence Daemon
systemctl enable nvidia-persistenced.service
systemctl start nvidia-persistenced.service

# Configure Kernel Parameters and DRM Kernel Mode Setting (KMS) for Nvidia (solves monitor detection problem)
echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia-drm.conf
sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 nvidia-drm.modeset=1"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Update initramfs
mkinitcpio -P

# Reboot to apply changes
echo "Nvidia drivers installed and configured. Please reboot your system to apply changes."
