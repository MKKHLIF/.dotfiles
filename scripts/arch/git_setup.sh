#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

pacman -S --noconfirm git

REAL_USER="mk"
USER_HOME="/home/mk"
SSH_DIR="$USER_HOME/.ssh"
KEY_FILE="$SSH_DIR/id_ed25519"
KNOWN_HOSTS="$SSH_DIR/known_hosts"

# Ensure .ssh directory exists with correct permissions
mkdir -p "$SSH_DIR"
chown "$REAL_USER:$REAL_USER" "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Check if SSH key exists
if [ -f "$KEY_FILE" ]; then
    read -p "SSH key already exists. Override Git identity and SSH key? (y/n): " OVERRIDE
    if [[ "$OVERRIDE" != "y" ]]; then
        echo "Skipping SSH and Git setup."
        exit 0
    fi

    rm -f "$KEY_FILE" "$KEY_FILE.pub"
fi

# Prompt for Git user identity
read -p "Enter your Git name: " GIT_NAME
read -p "Enter your Git email: " GIT_EMAIL

# Configure Git for the real user
sudo -u "$REAL_USER" git config --global user.name "$GIT_NAME"
sudo -u "$REAL_USER" git config --global user.email "$GIT_EMAIL"

# Generate new SSH key
sudo -u "$REAL_USER" ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$KEY_FILE" -N ""

# Ensure known_hosts file exists
touch "$KNOWN_HOSTS"
chown "$REAL_USER:$REAL_USER" "$KNOWN_HOSTS"
chmod 644 "$KNOWN_HOSTS"

# Start ssh-agent and add the key (under the invoking user environment)
sudo -u "$REAL_USER" bash -c "
    eval \$(ssh-agent -s)
    ssh-add '$KEY_FILE'
"

echo "Git and SSH setup complete."

