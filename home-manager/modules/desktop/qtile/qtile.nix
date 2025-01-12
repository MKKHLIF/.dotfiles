{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }:
let
  
in
{

  xdg.configFile."qtile" = {
    source = ./src;
    recursive = true;
  };

  home.packages = with pkgs; [
    
  ];
}
