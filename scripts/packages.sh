#!/bin/bash
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <packages dir>"
    exit 1
fi

PACKAGES_DIR="$1"

# Check if directory exists
if [ ! -d "$PACKAGES_DIR" ]; then
    echo "Packages directory not found!"
    exit 1
fi

# Function to install package
install_package() {
    local name="$1"
    local manager="$2"

    case "$manager" in
        zypper)
            sudo zypper install -y "$name"
            ;;
        opi)
            opi -n install "$name"
            ;;
        flatpak)
            flatpak install -y flathub "$name"
            ;;
        *)
            echo "Unsupported package manager: $manager"
            return 1
            ;;
    esac
}

# Track installed packages
declare -A installed_packages

# Process all JSON package files
for json_file in "$PACKAGES_DIR"/*.json; do
    if [ -f "$json_file" ]; then
        echo "Processing $(basename "$json_file")..."
        
        jq -c '.[]' "$json_file" | while read -r pkg; do
            name=$(echo "$pkg" | jq -r '.name')
            manager=$(echo "$pkg" | jq -r '.manager')

            if [[ -z "${installed_packages[$name]}" ]]; then
                if install_package "$name" "$manager"; then
                    installed_packages["$name"]="$manager"
                fi
            else
                echo "Package $name already installed via ${installed_packages[$name]}"
            fi
        done
    fi
done

echo "Package installation complete."