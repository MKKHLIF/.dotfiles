{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    
  };

  # Optionally, include rofi in your system's PATH
  home.packages = [
    pkgs.rofi
  ];
}
