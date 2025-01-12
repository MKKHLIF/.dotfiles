{ config, userSettings, pkgs, inputs, ... }:
let

in
{
  imports = [ ../utils/dbus.nix
              ../utils/gnome-keyring.nix
              ../utils/fonts.nix
            ];

  # Configure X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
    excludePackages = [ pkgs.xterm ];
  };

  # Configure libinput
  services.libinput.touchpad = {
    disableWhileTyping = true;
  };
}
