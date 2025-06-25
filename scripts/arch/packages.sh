#!/bin/bash

core_packages=(
    curl wget htop fastfetch git zsh tmux neovim ntfs-3g base-devel
    pipewire pipewire-pulse wireplumber vlc pavucontrol
    networkmanager bluez bluez-utils xorg-server xorg-xinit xorg-xrandr arandr brightnessctl acpi upower
)

qtile_packages=(qtile python-psutil python-iwlib rofi dmenu picom nitrogen kitty dolphin dunst libnotify lxappearance qt5ct qt6ct)
dev_packages=(gcc make cmake nodejs npm yarn docker docker-compose wireshark-qt visual-studio-code-bin jetbrains-toolbox postman-bin)
virt_packages=(qemu-desktop libvirt virt-manager virt-viewer edk2-ovmf bridge-utils dnsmasq iptables-nft)
font_packages=(ttf-jetbrains-mono ttf-dejavu ttf-liberation noto-fonts noto-fonts-emoji)
app_packages=(zathura zathura-pdf-mupdf qbittorrent telegram-desktop obsidian)

all_packages=(
    "${core_packages[@]}" "${qtile_packages[@]}" "${terminal_packages[@]}"
    "${dev_packages[@]}" "${virt_packages[@]}" "${font_packages[@]}" "${app_packages[@]}"
)

to_install=()
for pkg in "${all_packages[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        to_install+=("$pkg")
    fi
done

if [ ${#to_install[@]} -gt 0 ]; then
    echo -e "\e[1;34mInstalling missing packages with yay...\e[0m"
    yay -S --needed --noconfirm --combinedupgrade "${to_install[@]}"
else
    echo -e "\e[1;32mAll packages are already installed.\e[0m"
fi

