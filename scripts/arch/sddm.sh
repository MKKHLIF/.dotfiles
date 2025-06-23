#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi


set -e

# Run the remote setup script with automated input (1 then 6)
echo "Installing SDDM Astronaut theme with preset choices (1, then 6)..."

sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/MKKHLIF/sddm-astronaut-theme/master/setup.sh)" <<EOF
1
6
EOF

echo "SDDM Astronaut theme installed successfully."

