#!/bin/bash

groups_to_add=("libvirt" "docker" "video" "audio" "wheel" "wireshark" "kvm")

for group in "${groups_to_add[@]}"; do
    if ! id -nG "$ACTUAL_USER" | grep -qw "$group"; then
        usermod -aG "$group" "$ACTUAL_USER"
    fi
done

