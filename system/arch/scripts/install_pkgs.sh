#!/bin/bash

# Get the directory of the current script
script_dir=$(dirname "$0")

# Go one directory back
cd "$script_dir/.."

# Check if the "packages" directory exists
if [ -d "packages" ]; then
    # Loop through all the files in the "packages" directory
    for package_file in packages/*; do
        # Check if the file is a regular file (not a directory)
        if [ -f "$package_file" ]; then
            echo "Installing packages from $package_file..."
            # Install the packages listed in the file
            if command_exists paru; then
                paru -S --noconfirm --needed $(cat "$package_file")
            elif command_exists yay; then
                yay -S --noconfirm --needed $(cat "$package_file")
            elif command_exists pacman; then
                sudo pacman -S --noconfirm --needed $(cat "$package_file")
            else
                echo "Unable to find a compatible package manager. Please install the packages manually."
            fi
        fi
    done
else
    echo "The 'packages' directory does not exist. No packages to install."
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}