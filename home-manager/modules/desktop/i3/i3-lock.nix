{ inputs, config, lib, pkgs, ... }:
let
in
{

    home.packages = with pkgs; [
        i3lock-color
        scrot 
        imagemagick 
    ];
    
    programs.zsh.shellAliases = {
        lock = "i3lock";
    };

    home.file = {
        ".config/i3lock/lock.sh" = {
        source = ./src/scripts/lock.sh;
        force = true; # Ensures the folder is replaced as a symlink
        };
  };

}