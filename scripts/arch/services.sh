#!/bin/bash

echo "Enabling and starting services..."
services=(docker libvirtd NetworkManager bluetooth)

for service in "${services[@]}"; do
    systemctl enable --now $service
done

