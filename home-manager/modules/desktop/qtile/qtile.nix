{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }:
let
  
in
{

  home.file.qtile_config = {
    source = ./src;
    target = "${config.home}/.config/qtile/config.py";
    recursive = true;
  };

  home.packages = with pkgs; [
    
  ];
}