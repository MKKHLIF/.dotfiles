{ config, pkgs, userSettings, ... }:
let

in
{

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [

    # core modules
    ./core/bluetooth.nix

    # desktop environment 
    ./desktop/i3/i3.nix
    ./desktop/alacritty/alacritty.nix
    ./desktop/rofi/rofi.nix
    ./desktop/nitrogen/nitrogen.nix
    ./desktop/wallpapers/wallpapers.nix

    # cli modules
    ./cli/zsh.nix
    ./cli/git.nix
    ./cli/nvim/nvim.nix
    ./cli/tmux.nix
    
    # app modules
    ./app/brave.nix
    ./app/qemu.nix

    # stylix
    # ./modules/stylix/stylix.nix   
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



