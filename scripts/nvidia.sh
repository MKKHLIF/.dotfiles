#!/bin/bash

set -euo pipefail

# Log file setup
LOG_FILE="/var/log/nvidia_setup.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Function to log messages
log_message() {
    echo "[${TIMESTAMP}] $1" | tee -a "${LOG_FILE}"
}

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run as root"
        exit 1
    fi
}

# Function to check if package is installed
is_package_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Function to install package if not already installed
safe_install() {
    local package=$1
    if ! is_package_installed "${package}"; then
        log_message "Installing ${package}..."
        pacman -S --noconfirm "${package}"
    else
        log_message "${package} is already installed"
    fi
}

# Function to backup old configuration
backup_config() {
    local file=$1
    if [ -f "${file}" ]; then
        local backup="${file}.backup.${TIMESTAMP}"
        log_message "Creating backup of ${file} to ${backup}"
        cp "${file}" "${backup}"
    fi
}

# Function to detect NVIDIA BusID
get_nvidia_busid() {
    # Install lshw if not present
    safe_install "lshw"
    
    # Try to get BusID using lspci first (more reliable)
    local busid=$(lspci | grep -i nvidia | grep -i vga | cut -d' ' -f1)
    
    if [ -n "$busid" ]; then
        # Convert from lspci format (01:00.0) to PCI:1:0:0 format
        local bus=$(echo "$busid" | cut -d: -f1)
        local dev=$(echo "$busid" | cut -d: -f2 | cut -d. -f1)
        local func=$(echo "$busid" | cut -d. -f2)
        echo "PCI:$((16#$bus)):$((16#$dev)):$((16#$func))"
        return 0
    fi
    
    return 1
}

# Function to configure Wayland environment
setup_wayland() {
    local envd_file="/etc/environment.d/nvidia-wayland.conf"
    backup_config "${envd_file}"

    log_message "Setting up Wayland environment variables..."
    cat > "${envd_file}" << EOF
# NVIDIA Wayland Setup
GBM_BACKEND=nvidia-drm
__GLX_VENDOR_LIBRARY_NAME=nvidia
LIBVA_DRIVER_NAME=nvidia
WLR_NO_HARDWARE_CURSORS=1
XWAYLAND_NO_GLAMOR=1
__GL_GSYNC_ALLOWED=1
__GL_VRR_ALLOWED=1
EOF
}

# Main installation function
main() {
    check_root

    log_message "Starting NVIDIA driver installation for RTX 3050 laptop"

    # Ensure system is up to date
    log_message "Updating system packages..."
    pacman -Syu --noconfirm

    # Install required packages
    local packages=(
        "nvidia-dkms"         # Using DKMS instead of nvidia package
        "nvidia-utils"
        "nvidia-settings"
        "nvidia-prime"
        "lib32-nvidia-utils"  # For 32-bit support
        "opencl-nvidia"       # For CUDA/OpenCL support
        "egl-wayland"         # For Wayland support
        "libvdpau"           # Video acceleration
        "libglvnd"           # GL Vendor-Neutral Dispatch
    )

    for package in "${packages[@]}"; do
        safe_install "${package}"
    done

    # Get NVIDIA BusID
    log_message "Detecting NVIDIA GPU BusID..."
    local nvidia_busid
    if ! nvidia_busid=$(get_nvidia_busid); then
        log_message "Warning: Could not detect NVIDIA GPU BusID. This might cause issues in hybrid graphics systems."
    fi

    # Create or update Xorg configuration
    local xorg_conf="/etc/X11/xorg.conf.d/10-nvidia.conf"
    backup_config "${xorg_conf}"

    log_message "Creating Xorg configuration..."
    {
        echo 'Section "Device"'
        echo '    Identifier "NVIDIA Card"'
        echo '    Driver     "nvidia"'
        if [ -n "${nvidia_busid:-}" ]; then
            echo "    BusID      \"$nvidia_busid\""
        fi
        echo '    Option     "NoLogo" "true"'
        echo '    Option     "RegistryDwords" "EnableBrightnessControl=1"'
        echo '    Option     "PrimaryGPU" "yes"'
        echo '    Option     "AllowEmptyInitialConfiguration" "yes"'  # For Wayland compatibility
        echo '    Option     "UseNvKmsCompositor" "yes"'             # Better Wayland performance
        echo '    Option     "TripleBuffer" "on"'                    # Better performance
        echo 'EndSection'
    } > "${xorg_conf}"

    # Update mkinitcpio configuration
    local mkinitcpio_conf="/etc/mkinitcpio.conf"
    backup_config "${mkinitcpio_conf}"

    # Add nvidia module to mkinitcpio if not already present
    if ! grep -q '^MODULES=.*nvidia' "${mkinitcpio_conf}"; then
        log_message "Updating mkinitcpio configuration..."
        sed -i 's/^MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /' "${mkinitcpio_conf}"
        
        log_message "Regenerating initramfs..."
        mkinitcpio -P
    fi

    # Configure kernel parameters for better hardware support
    local grub_default="/etc/default/grub"
    backup_config "${grub_default}"

    if ! grep -q "nvidia-drm.modeset=1" "${grub_default}"; then
        log_message "Updating GRUB configuration..."
        # Add Wayland-specific kernel parameters
        sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1 /' "${grub_default}"
        
        log_message "Updating GRUB..."
        grub-mkconfig -o /boot/grub/grub.cfg
    fi

    # Setup Wayland environment
    setup_wayland

    # Enable required services
    local services=(
        "nvidia-persistenced.service"
    )

    for service in "${services[@]}"; do
        if ! systemctl is-enabled --quiet "${service}"; then
            log_message "Enabling ${service}..."
            systemctl enable "${service}"
            systemctl start "${service}"
        fi
    done

    log_message "Installation completed successfully"
    log_message "Please reboot your system to apply all changes"
    log_message "Note: For Wayland sessions, make sure your display manager supports Wayland"
}

# Run main function and handle errors
if ! main; then
    log_message "Error: Installation failed"
    exit 1
fi