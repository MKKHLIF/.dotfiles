{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
  };

  home.file = {
    ".config/rofi" = {
      source = ./src;
      recursive = true;
      force = true; # Ensures the folder is replaced as a symlink
    };
  };

  home.packages = [
    pkgs.rofi
  ];
}
