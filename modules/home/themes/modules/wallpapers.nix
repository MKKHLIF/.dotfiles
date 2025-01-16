{ config, pkgs, ... }:

{
    home.file = {
        ".config/wallpapers" = {
        source = ../../../../wallpapers;
        recursive = true;
        force = true; # Ensures the folder is replaced as a symlink
        };
    };
}
