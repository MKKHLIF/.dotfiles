#!/bin/bash

# Set the source and target directories
source_dir="$HOME/.dotfile/.config"
target_dir="$HOME/.config"

# Create the .config directory if it doesn't exist
if [ ! -d "$target_dir" ]; then
    mkdir "$target_dir"
    echo "Created $target_dir directory."
fi

# Loop through each subdirectory in the source directory
for dir in "$source_dir"/*/
do
    # Get the basename of the subdirectory
    subdir_name=$(basename "$dir")
    
    # Create the target subdirectory path
    target_subdir="$target_dir/$subdir_name"
    
    # Check if the target subdirectory already has a symlink
    if [ -L "$target_subdir" ]; then
        echo "Symlink already exists for $subdir_name, skipping..."
    else
        # Create the symlink
        ln -s "$dir" "$target_subdir"
        echo "Created symlink: $target_subdir -> $dir"
    fi
done

echo "Symlink creation completed."
