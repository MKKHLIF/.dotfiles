#!/bin/bash

# Ensure script is executed from the correct directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [[ "$SCRIPT_DIR" != "$PWD" ]]; then
    echo "Please run this script from the directory where it is located."
    exit 1
fi

# Clone wlsunset repository
git clone https://github.com/kennylevinsen/wlsunset.git || { echo "Failed to clone wlsunset repository"; exit 1; }
cd wlsunset || { echo "Failed to change directory to wlsunset"; exit 1; }

# Build wlsunset
meson build || { echo "Failed to configure meson build"; exit 1; }
ninja -C build || { echo "Failed to build wlsunset"; exit 1; }
sudo ninja -C build install || { echo "Failed to install wlsunset"; exit 1; }

# Clean up
cd ..
rm -rf ./wlsunset/ || { echo "Failed to remove wlsunset directory"; exit 1; }

echo "Installation completed successfully."
