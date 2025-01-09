{ config, pkgs, userSettings, ... }:
let

in
{

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [

    # Low Level Modules
    ./modules/low-level/bluetooth.nix

    # Desktop Environment 
    ./modules/desktop-enviorment/hyprland.nix
    ./modules/desktop-enviorment/kitty.nix
    # ./modules/desktop-enviorment/zsh.nix
    
    # stylix
    # ./modules/stylix/stylix.nix    
    
    # App Modules
    ./modules/app/pkgs.nix
    ./modules/app/git.nix
    ./modules/app/brave.nix
    ./modules/app/qemu.nix
    # ./modules/app/nvim.nix

  ];



  home.file = {
    
  };

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



