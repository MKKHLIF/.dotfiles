{ config, userSettings, pkgs, ... }:
let

in
{
  imports = [ ./dbus.nix
              ./gnome-keyring.nix
              ./fonts.nix
            ];

  environment.systemPackages = with pkgs;
    [ 
      wayland 
      waydroid
    ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
  };


  # securtiy
  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
  };

}