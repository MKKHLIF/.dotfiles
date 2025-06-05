#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

echo -e "\e[1;32m"
echo "  ____                   _____ _    _ _____ _____ "
echo " / __ \                 / ____| |  | / ____|  ___|"
echo "| |  | |_ __   ___ _ _| (___ | |  | | (___ | |__  "
echo "| |  | | '_ \ / _ \ '_ \\___ \| |  | |\___ \|  __| "
echo "| |__| | |_) |  __/ | | |___) | |__| |____) | |___ "
echo " \____/| .__/ \___|_| |_|____/ \____/|_____/|_____|"
echo "       | |"
echo "       |_|"
echo -e "\e[0m" 

read -p "Enter your Git name: " GIT_NAME
read -p "Enter your Git email: " GIT_EMAIL

echo "Updating the system..."
sudo zypper refresh
sudo zypper update -y

############# GIT #################


sudo zypper --non-interactive install git

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "Setting git identity..."
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    echo "Git identity set: Name='$GIT_NAME', Email='$GIT_EMAIL'"

    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
    echo "SSH key was generated."
else
    echo "Git identity is already set."
fi
echo "Git setup complete."


############# OPI #################

echo "Installing opi..."
sudo zypper install -y opi
echo "opi was installed successfully."

############# FLATPAK #################

echo "Enabling flatpak"
echo "Installing Flatpak..."
sudo zypper install -y flatpak

echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

############# PAKCAGES #################

packages=(
  qemu-kvm libvirt virt-manager virt-viewer proton-vpn jetbrains-mono-fonts bluez NetworkManager hyprland-qtutils
  hyprland hyprpaper hypridle hyprlock hyprcursor slurp grim swappy waybar wofi kitty dunst dolphin fastfetch zathura zsh
  pipewire wireplumber xdg-desktop-portal-hyprland xdg-desktop-portal-gtk qt6-wayland hyprpolkitagent neovim tmux docker
  docker-compose wireshark gcc make cmake yarn npm cargo rust git curl wget ntfs-3g htop vlc
  qtile rofi dmenu picom nitrogen xrandr arandr conky
)
 
to_install=()
for pkg in "${packages[@]}"; do
  if ! rpm -q "$pkg" &>/dev/null; then
    to_install+=("$pkg")
  fi
done

if [ ${#to_install[@]} -gt 0 ]; then
  sudo zypper --non-interactive install "${to_install[@]}"
else
  echo "All packages are already installed."
fi
opi --no-confirm install brave vscode codecs

sudo flatpak install -y flathub com.discordapp.Discord
sudo flatpak install -y flathub md.obsidian.Obsidian
sudo flatpak install -y flathub org.telegram.desktop
sudo flatpak install -y flathub net.ankiweb.Anki
sudo flatpak install -y flathub com.jetbrains.CLion
sudo flatpak install -y flathub com.jetbrains.WebStorm

############# SERVICES #################

if ! systemctl is-enabled --quiet docker; then
    sudo systemctl enable docker
fi

if ! systemctl is-active --quiet docker; then
    sudo systemctl start docker
fi

if ! systemctl is-enabled --quiet libvirtd; then
    sudo systemctl enable libvirtd
fi

if ! systemctl is-active --quiet libvirtd; then
    sudo systemctl start libvirtd
fi

############# GROUPS #################

groups_to_add=("libvirt" "docker" "video" "audio" "wheel" "dialout")
current_user=$(whoami)

for group in "${groups_to_add[@]}"; do
    if id -nG "$current_user" | grep -qw "$group"; then
        echo "$current_user is already in the $group group."
    else
        echo "Adding $current_user to the $group group..."
        sudo usermod -aG "$group" "$current_user"
    fi
done


OLDPWD=$(pwd)

############# SDDM #################

yes 1 | sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/MKKHLIF/sddm-astronaut-theme/master/setup.sh)"
cd "$OLDPWD"

############# ZSH #################

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed."
else
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
cd "$OLDPWD"

############# SYMLINKS #################

SOURCE_DIR="./config"

create_symlinks() {
  local src_dir="$1"
  local tgt_dir="$2"
  
  find "$src_dir" -type f | while read src_file; do
    # Get the relative path by removing the source directory from the full path
    rel_path="${src_file#$src_dir/}"
    
    # Construct the target symlink path
    tgt_file="$tgt_dir/$rel_path"
    
    # Ensure the target directory exists
    mkdir -p "$(dirname "$tgt_file")"
    
    # Use absolute paths for the symlinks
    abs_src_file="$(realpath "$src_file")"

    # Force replace the symlink or existing file if it exists
    sudo ln -sf "$abs_src_file" "$tgt_file"
    echo "Created or replaced symlink: $tgt_file -> $abs_src_file"
  done
}

mkdir -p "/home/mk/.config"
create_symlinks "$SOURCE_DIR" "/home/mk/.config"
create_symlinks "$SOURCE_DIR" "/home/mk/.local/share/icons"



