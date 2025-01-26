#!/bin/bash

groups_to_add=("libvirt" "docker" "video" "audio" "wheel" "dialout")
current_user=$(whoami)

# Check if the user is already in each group, and add them if not
for group in "${groups_to_add[@]}"; do
    if id -nG "$current_user" | grep -qw "$group"; then
        echo "$current_user is already in the $group group."
    else
        echo "Adding $current_user to the $group group..."
        sudo usermod -aG "$group" "$current_user"
    fi
done

echo "You need to log out and log back in for group changes to take effect."
