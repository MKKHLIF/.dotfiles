#!/bin/bash

core_packages=(curl wget htop fastfetch git zsh tmux neovim ntfs-3g base-devel)
audio_video_packages=(pipewire pipewire-pulse wireplumber vlc pulseaudio-utils pavucontrol)
network_packages=(networkmanager networkmanager-applet bluez bluez-utils)
qtile_packages=(qtile python-psutil python-iwlib rofi dmenu picom nitrogen feh xorg-server xorg-xinit xorg-xrandr arandr conky)
terminal_packages=(kitty alacritty dolphin thunar dunst libnotify grim slurp swappy brightnessctl acpi upower)
dev_packages=(gcc make cmake nodejs npm yarn rustup docker docker-compose wireshark-qt)
virt_packages=(qemu-desktop libvirt virt-manager virt-viewer edk2-ovmf bridge-utils dnsmasq iptables-nft)
font_packages=(ttf-jetbrains-mono ttf-dejavu ttf-liberation noto-fonts noto-fonts-emoji)
app_packages=(zathura zathura-pdf-mupdf qbittorrent)

all_packages=(
    "${core_packages[@]}" "${audio_video_packages[@]}" "${network_packages[@]}"
    "${qtile_packages[@]}" "${terminal_packages[@]}" "${dev_packages[@]}"
    "${virt_packages[@]}" "${font_packages[@]}" "${app_packages[@]}"
)

to_install=()
for pkg in "${all_packages[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        to_install+=("$pkg")
    fi
done

if [ ${#to_install[@]} -gt 0 ]; then
    pacman -S --noconfirm "${to_install[@]}"
else
    echo "All packages are already installed."
fi

