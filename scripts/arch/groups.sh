#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

ACTUAL_USER="mk"

groups_to_add=("libvirt" "docker" "video" "audio" "wheel" "wireshark" "kvm")

for group in "${groups_to_add[@]}"; do
    if ! id -nG "$ACTUAL_USER" | grep -qw "$group"; then
        usermod -aG "$group" "$ACTUAL_USER"
        echo "Added $ACTUAL_USER to $group"
    else
        echo "$ACTUAL_USER is already in $group"
    fi
done

