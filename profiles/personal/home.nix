{ config, pkgs, userSettings, ... }:

{

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../user/hardware/bluetooth/bluetooth.nix   # bluetooth

    # app
    ../../user/app/git/git.nix
    ../../user/app/virtualization/virtualization.nix
    ../../user/app/browser/brave.nix
    ../../user/app/terminal/kitty.nix
    ../../user/app/terminal/alacritty.nix
    ../../user/app/nvim/nvim.nix

    ../../user/shell/sh.nix         # shell 
    ../../user/style/stylix.nix     # styles

  ];

  home.packages = [
    pkgs.hello
    pkgs.tmux
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



