{ config, pkgs, userSettings, ... }:
let

in
{

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    
    ./services/default.nix
    ./themes/default.nix
    ./desktop/default.nix
    ./cli/default.nix
    ./apps/default.nix
   
  ];

  home.packages = [
    pkgs.discord
    pkgs.anki
    pkgs.obsidian
    pkgs.telegram-desktop 
    pkgs.jetbrains.clion
    pkgs.qbittorrent
  ];

  home.stateVersion = "24.05"; # Please read the comment before changing.

} 



