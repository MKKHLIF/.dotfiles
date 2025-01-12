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
    ./modules/core/bluetooth.nix

    # desktop environment 
    ./modules/desktop/i3.nix
    ./modules/desktop/alacritty/alacritty.nix
    ./modules/desktop/rofi/rofi.nix
    ./modules/desktop/nitrogen/nitrogen.nix

    # cli modules
    ./modules/cli/zsh.nix
    ./modules/cli/git.nix
    ./modules/cli/nvim.nix
    ./modules/cli/tmux.nix
    
    # app modules
    ./modules/app/brave.nix
    ./modules/app/qemu.nix

    # stylix
    # ./modules/stylix/stylix.nix   
  ];



  home.packages = [
    pkgs.discord
    pkgs.anki
    pkgs.obsidian
    pkgs.telegram-desktop
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mk/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.stateVersion = "24.05"; # Please read the comment before changing.

} 



