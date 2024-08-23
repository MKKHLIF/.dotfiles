#!/bin/bash

# Set the source and target directories
source_dir=$HOME/.dotfiles/config
target_dir=$HOME/.config

# Create the .config directory if it doesn't exist
if [ ! -d "$target_dir" ]; then
    mkdir "$target_dir"
    echo "Created $target_dir directory."
fi

# Loop through each subdirectory in the source directory
for dir in $source_dir/*/
do
    # Get the basename of the subdirectory
    subdir_name=$(basename "$dir")
    echo $subdir_name

    # Create the target subdirectory path
    target_subdir="$target_dir/$subdir_name"
    echo $target_subdir

    # Remove existing symlink or directory
    if [ -e "$target_subdir" ] || [ -L "$target_subdir" ]; then
        rm -rf "$target_subdir"
        echo "Removed existing $target_subdir"
    fi

    # Create the symlink
    ln -s "$dir" "$target_subdir"
    echo "Created symlink: $target_subdir -> $dir"
done
