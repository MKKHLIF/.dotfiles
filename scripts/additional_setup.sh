#!/bin/bash

# ============================== GIT IDENTITY ===================================
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing git..."
    sudo pacman -Syu --noconfirm git
else
    echo "Git is already installed."
fi

read -p "Enter your Git email: " git_email

echo "Generating SSH key..."
ssh-keygen -t ed25519 -C "$git_email" -N "" -f ~/.ssh/id_ed25519

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

read -p "Enter your Git username: " git_username

git config --global user.name "$git_username"
git config --global user.email "$git_email"

echo "Git has been installed and configured with the following details:"
echo "Username: $git_username"
echo "Email: $git_email"
echo "Your SSH key has been generated and added to the ssh-agent."
echo "Public key:"
cat ~/.ssh/id_ed25519.pub

# ============================== WLSUNSET ===================================
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [[ "$SCRIPT_DIR" != "$PWD" ]]; then
    echo "Please run this script from the directory where it is located."
    exit 1
fi

git clone https://github.com/kennylevinsen/wlsunset.git || { echo "Failed to clone wlsunset repository"; exit 1; }
cd wlsunset || { echo "Failed to change directory to wlsunset"; exit 1; }

meson build || { echo "Failed to configure meson build"; exit 1; }
ninja -C build || { echo "Failed to build wlsunset"; exit 1; }
sudo ninja -C build install || { echo "Failed to install wlsunset"; exit 1; }

cd ..
rm -rf ./wlsunset/ || { echo "Failed to remove wlsunset directory"; exit 1; }

echo "Installation completed successfully."


# ============================== SYSTEM SERVICES ===================================
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
