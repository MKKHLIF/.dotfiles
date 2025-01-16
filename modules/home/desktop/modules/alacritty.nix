{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

  };

  home.file = {
    ".config/alacrity" = {
      source = ../../_config/alacritty;
      recursive = true;
      force = true; # Ensures the folder is replaced as a symlink
    };
  };

  # Optionally, include Alacritty in the PATH
  home.packages = [
    pkgs.alacritty
  ];
}
