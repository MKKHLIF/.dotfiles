#!/bin/bash

packages_dir=$HOME/.dotfiles/system/arch/packages

for file in $packages_dir/*.list; do
    if [ -f "$list_file"]; then 
        file_name=$(basename "$file" .list)
        echo " ===== Installing list: $file_name ===== "
        while read -r pkg; do
            paru -S --noconfirm --needed $pkg
        done < $file
    fi
done

command_exists() {
    command -v "$1" >/dev/null 2>&1
}