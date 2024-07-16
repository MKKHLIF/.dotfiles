#!/bin/bash

# ==================== ====== Refresh top 10 mirrors by rate ==================== ====== 
echo "Refreshing top 10 mirrors by download rate..."
reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
echo "Mirrorlist updated successfully"

echo "Updating package database and upgrading system..."
pacman -Syu --noconfirm


# ==================== ============ AUR helpers  ==================== ==================
echo "Updating package list and installing essential tools..."
sudo pacman -Sy --noconfirm git base-devel

echo "Installing Paru AUR helper..."
cd /tmp
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si --noconfirm

echo "Installing Yay AUR helper..."
cd /tmp
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm

echo "Cleaning up temporary files..."
rm -rf /tmp/paru-bin
rm -rf /tmp/yay-bin

echo "Paru and Yay installation completed successfully."


# ==================== ============ NVIDIA  ==================== =======================
echo "Setting NVIDIA drivers..."
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


# ==================== ============ PACKAGES =========== ===============================

echo "Installing personal packages and tools..."
install_packages() {
    local file=$1
    local description=$2
    
    if [[ -f $file ]]; then
        echo "Installing $description..."
        while read -r package; do
            yay -S --noconfirm --needed "$package"
        done < "$file"
        echo "$description installed successfully."
    else
        echo "Error: $file not found. Exiting."
        exit 1
    fi
}

SCRIPT_DIR=$(dirname "$0")

echo "Updating package list and installing common development tools..."
sudo pacman -Sy --noconfirm git base-devel neovim vi

install_packages "$SCRIPT_DIR/../packages/system.list" "system packages"
install_packages "$SCRIPT_DIR/../packages/software.list" "software & tools"
install_packages "$SCRIPT_DIR/../packages/development.list" "development tools"


echo "Setup process completed successfully!"