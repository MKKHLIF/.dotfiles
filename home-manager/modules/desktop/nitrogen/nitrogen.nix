{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nitrogen
  ];

  home.file = {
    ".config/nitrogen/nitrogen.cfg".source = ./nitrogen.cfg;
    "wallpapers".source = ../../../../wallpapers;
  };
}
