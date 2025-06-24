#!/bin/bash

USER_HOME=$(eval echo ~$ACTUAL_USER)
SOURCE_DIR="$USER_HOME/.dotfiles/config"

create_symlinks() {
    local src_dir="$1"
    local tgt_dir="$2"

    if [ ! -d "$src_dir" ]; then
        echo "Source directory $src_dir does not exist."
        return
    fi

    find "$src_dir" -type f | while read -r src_file; do
        rel_path="${src_file#$src_dir/}"
        tgt_file="$tgt_dir/$rel_path"
        mkdir -p "$(dirname "$tgt_file")"
        abs_src_file="$(realpath "$src_file")"
        ln -sf "$abs_src_file" "$tgt_file"
        chown "$ACTUAL_USER:$ACTUAL_USER" "$tgt_file"
        echo -e "\e[34mCreated symlink:\e[0m $tgt_file"
    done
}

mkdir -p "$USER_HOME/.config"
mkdir -p "$USER_HOME/.local/share/icons"
chown "$ACTUAL_USER:$ACTUAL_USER" "$USER_HOME/.config"
chown "$ACTUAL_USER:$ACTUAL_USER" "$USER_HOME/.local/share/icons"

create_symlinks "$SOURCE_DIR" "$USER_HOME/.config"
create_symlinks "$SOURCE_DIR" "$USER_HOME/.local/share/icons"

