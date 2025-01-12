{ config, pkgs, ... }:

{
    home.file = {
        ".config/wallpapers" = {
        source = ./src/wallpapers;
        recursive = true;
        force = true; # Ensures the folder is replaced as a symlink
        };
    };
}
