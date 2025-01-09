{ config, userSettings, pkgs, ... }:
let
  enableHyprland = userSettings.wm == "hyprland";

  wmServices = if enableHyprland then {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
  } else {};
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

  programs = wmServices;  # This will either be the Hyprland configuration or an empty set

}