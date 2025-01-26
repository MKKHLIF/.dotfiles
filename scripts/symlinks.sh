#!/bin/bash

# The source directory for the dotfiles (e.g., ./config)
SOURCE_DIR="../config"

# The target directory where symlinks will be created (e.g., ~/.config)
TARGET_DIR="$HOME/.config"

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Function to create symlinks
create_symlinks() {
  local src_dir="$1"
  local tgt_dir="$2"
  
  # Iterate through the source directory recursively
  find "$src_dir" -type f | while read src_file; do
    # Get the relative path by removing the source directory from the full path
    rel_path="${src_file#$src_dir/}"
    
    # Construct the target symlink path
    tgt_file="$tgt_dir/$rel_path"
    
    # Ensure the target directory exists
    mkdir -p "$(dirname "$tgt_file")"
    
    # Use absolute paths for the symlinks
    abs_src_file="$(realpath "$src_file")"

    # Force replace the symlink or existing file if it exists
    ln -sf "$abs_src_file" "$tgt_file"
    echo "Created or replaced symlink: $tgt_file -> $abs_src_file"
  done
}

# Call the function to create symlinks
create_symlinks "$SOURCE_DIR" "$TARGET_DIR"

create_symlinks "$SOURCE_DIR" "/home/mk/.local/share/icons"
