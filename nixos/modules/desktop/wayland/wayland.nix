{ config, userSettings, pkgs, inputs, ... }:
let

in
{
  imports = [ ../utils/dbus.nix
              ../utils/gnome-keyring.nix
              ../utils/fonts.nix
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

}