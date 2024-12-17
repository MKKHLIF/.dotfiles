{ config, pkgs, ... }:

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
}