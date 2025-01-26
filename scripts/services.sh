#!/bin/bash

# Enable and start Docker service
echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Enable and start QEMU Virt Manager (libvirtd) service
echo "Enabling and starting QEMU Virt Manager (libvirtd) service..."
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
