{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nitrogen
  ];

home.file.".config/nitrogen/nitrogen.cfg" = {
  source = ./nitrogen.cfg;
  force = true;
};
home.file."wallpapers" = {
  source = ../../../../wallpapers;
  force = true;
};

}
