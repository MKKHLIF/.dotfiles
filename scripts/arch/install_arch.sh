#!/bin/bash

# Function to safely execute commands with error handling
safe_run() {
    if ! "$@"; then
        echo "An error occurred with command: $*"
        exit 1
    fi
}

# ==================== ====== Refresh top 10 mirrors by rate ==================== ====== 
echo "Refreshing top 10 mirrors by download rate..."
safe_run reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
echo "Mirrorlist updated successfully"

echo "Updating package database and upgrading system..."
safe_run pacman -Syu --noconfirm

# ==================== ============ AUR helpers  ==================== ==================
echo "Updating package list and installing essential tools..."
safe_run sudo pacman -Sy --noconfirm git base-devel

install_aur_helper() {
    local url=$1
    local dir_name=$(basename "$url" .git)

    echo "Installing $dir_name AUR helper..."
    safe_run cd /tmp
    safe_run git clone "$url"
    safe_run cd "$dir_name"
    safe_run makepkg -si --noconfirm
    safe_run cd ..
    safe_run rm -rf "$dir_name"
    echo "$dir_name installation completed successfully."
}

install_aur_helper https://aur.archlinux.org/paru-bin.git
install_aur_helper https://aur.archlinux.org/yay-bin.git

# ==================== ============ NVIDIA  ==================== =======================
echo "Setting NVIDIA drivers..."
# Install Nvidia proprietary drivers
safe_run pacman -Syu --noconfirm
safe_run pacman -S --noconfirm nvidia-dkms nvidia-utils nvidia-settings

# Enable Nvidia Persistence Daemon
safe_run systemctl enable nvidia-persistenced.service
safe_run systemctl start nvidia-persistenced.service

# Configure Kernel Parameters and DRM Kernel Mode Setting (KMS) for Nvidia
safe_run echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia-drm.conf
safe_run sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 nvidia-drm.modeset=1"/' /etc/default/grub
safe_run grub-mkconfig -o /boot/grub/grub.cfg

# Update initramfs
safe_run mkinitcpio -P

echo "Nvidia drivers installed and configured. Please reboot your system to apply changes."

# ==================== ============ PACKAGES =========== ===============================
echo "Installing personal packages and tools..."
install_packages() {
    local file=$1
    local description=$2
    
    if [[ -f $file ]]; then
        echo "Installing $description..."
        while IFS= read -r package || [[ -n "$package" ]]; do
            safe_run yay -S --noconfirm --needed "$package"
        done < "$file"
        echo "$description installed successfully."
    else
        echo "Error: $file not found. Exiting."
        exit 1
    fi
}

SCRIPT_DIR=$(dirname "$0")

echo "Updating package list and installing common development tools..."
safe_run sudo pacman -Sy --noconfirm git base-devel neovim vi

install_packages "$SCRIPT_DIR/../packages/system.list" "system packages"
install_packages "$SCRIPT_DIR/../packages/software.list" "software & tools"
install_packages "$SCRIPT_DIR/../packages/development.list" "development tools"

echo "Setup process completed successfully!"