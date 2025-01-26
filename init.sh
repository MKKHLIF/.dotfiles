#!/bin/bash

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

############# VARIABLES #################

SCRIPTS_DIR="scripts/"
CONFIG_DIR="config/"
PACKAGES_DIR="packages/"
GIT_NAME="mk"
GIT_EMAIL="example@example.example"

############# SYSTEM UPDATE #################

echo "Updating the system..."
sudo zypper refresh
sudo zypper update -y

############# GIT IDENTITY #################

echo "Setting up Git identity..."

sudo zypper -y install git
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
echo "Git identity set: Name='$GIT_NAME', Email='$GIT_EMAIL'"

# Skip SSH key generation if key already exists
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    # Generate SSH key
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
    echo "SSH key was generated."
else
    echo "SSH key already exists. Skipping key generation."
fi
echo "Git setup complete."


############# OPI SETUP #################

echo "Installing opi..."
sudo zypper install -y opi
echo "opi was installed successfully."

############# ENABLE FLATPAK #################

echo "Enabling flatpak"
# Install Flatpak
echo "Installing Flatpak..."
sudo zypper install -y flatpak

# Add the Flathub repository if not already added
echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


############# INSTALL PAKCAGES #################

echo "Installing Packages"
sudo $SCRIPTS_DIR/packages.sh $PACKAGES_DIR


############# USER GROUPS #################

echo "user groups"
sudo $SCRIPTS_DIR/groups.sh

############# START SERVICES #################

echo "Starting services"
sudo $SCRIPTS_DIR/services.sh

############# CREATE SYMLINKS #################
echo "Creating dotfiles symlinks"
# need dir path argument 
sudo $SCRIPTS_DIR/symlinks.sh


echo "Reboot Now? (y/n)"
# to do ...