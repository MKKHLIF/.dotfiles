{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

  };

  home.file = {
    ".config/alacrity" = {
      source = ./src;
      recursive = true;
      force = true; # Ensures the folder is replaced as a symlink
    };
  };

  # Optionally, include Alacritty in the PATH
  home.packages = [
    pkgs.alacritty
  ];
}
