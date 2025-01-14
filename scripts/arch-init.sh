#!/bin/bash

# base.sh - Base system configuration
setup_base() {
    # Error handling
    set -euo pipefail
    
    # Check if running as root
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run as root"
        exit 1
    }
    
    # Install base packages
    pacman -Syu --noconfirm --needed \
        base-devel wget vim git pciutils zip unzip htop neofetch lshw

    # Configure hostname and networking
    if [ ! -f /etc/hostname ]; then
        read -p "Enter hostname: " hostname
        echo "$hostname" > /etc/hostname
    fi

    # Enable NetworkManager
    pacman -S --noconfirm --needed networkmanager
    systemctl enable NetworkManager
    systemctl start NetworkManager
}

# nvidia.sh - NVIDIA driver installation
setup_nvidia() {
    # Install NVIDIA drivers and utilities
    pacman -S --noconfirm --needed \
        nvidia nvidia-utils nvidia-settings nvidia-prime

    # Create NVIDIA configuration
    cat > /etc/X11/xorg.conf.d/10-nvidia.conf << EOF
Section "Device"
    Identifier "NVIDIA Card"
    Driver "nvidia"
    BusID "PCI:1:0:0"  # Adjust this based on your system
    Option "PrimaryGPU" "yes"
EndSection
EOF

    # Enable power management
    cat > /etc/modprobe.d/nvidia.conf << EOF
options nvidia NVreg_DynamicPowerManagement=0x02
EOF
}

# display.sh - Display server and desktop environment setup
setup_display() {
    # Install X11 and Wayland
    pacman -S --noconfirm --needed \
        xorg-server xorg-xinit xorg-apps \
        wayland xorg-xwayland

    # Install SDDM and theme
    pacman -S --noconfirm --needed sddm qt5-graphicaleffects qt5-quickcontrols2

    # Install Catppuccin SDDM theme
    git clone https://github.com/catppuccin/sddm.git /tmp/catppuccin-sddm
    cp -r /tmp/catppuccin-sddm/src/catppuccin-mocha /usr/share/sddm/themes/
    
    # Configure SDDM
    cat > /etc/sddm.conf << EOF
[Theme]
Current=catppuccin-mocha
EOF

    systemctl enable sddm
}

# grub.sh - GRUB configuration
setup_grub() {
    # Install GRUB theme
    git clone https://github.com/vinceliuice/grub2-themes.git /tmp/grub2-themes
    bash /tmp/grub2-themes/install.sh -t vimix -s 1080p

    # Update GRUB configuration
    sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=5/' /etc/default/grub
    sed -i 's/GRUB_THEME=.*/GRUB_THEME="\/usr\/share\/grub\/themes\/vimix\/theme.txt"/' /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

# shell.sh - ZSH setup
setup_zsh() {
    # Install and configure ZSH
    pacman -S --noconfirm --needed zsh zsh-completions

    # Set ZSH as default shell for new users
    sed -i 's/SHELL=.*/SHELL=\/bin\/zsh/' /etc/default/useradd
    
    # Install Oh My Zsh (optional)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# virtualization.sh - QEMU/KVM setup
setup_virtualization() {
    # Install QEMU and related packages
    pacman -S --noconfirm --needed \
        qemu-full virt-manager libvirt edk2-ovmf dnsmasq

    # Enable and start libvirtd
    systemctl enable libvirtd
    systemctl start libvirtd

    # Configure network bridge
    cat > /etc/NetworkManager/conf.d/bridge.conf << EOF
[keyfile]
unmanaged-devices=none
EOF
}

# firewall.sh - Firewall configuration
setup_firewall() {
    # Install and configure firewall
    pacman -S --noconfirm --needed ufw

    # Configure basic rules
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow 22000/tcp  # Syncthing
    ufw allow 21027/tcp
    ufw allow 5353/udp
    ufw allow 22000/udp
    ufw allow 21027/udp

    # Enable firewall
    ufw enable
    systemctl enable ufw
    systemctl start ufw
}

# themes.sh - System-wide theming
setup_themes() {
    # Install themes and icons
    pacman -S --noconfirm --needed \
        arc-gtk-theme papirus-icon-theme \
        noto-fonts noto-fonts-cjk noto-fonts-emoji \
        ttf-dejavu ttf-liberation

    # Install Gruvbox GTK theme
    git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk /tmp/gruvbox-theme
    cp -r /tmp/gruvbox-theme/themes/* /usr/share/themes/
}

# main.sh - Main installation script
main() {
    setup_base
    setup_nvidia
    setup_display
    setup_grub
    setup_zsh
    setup_virtualization
    setup_firewall
    setup_themes
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi