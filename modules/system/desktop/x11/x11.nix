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
      layout = "us,ara";
      variant = "";
      options = "grp:alt_shift_toggle";
      
    };
    excludePackages = [ pkgs.xterm ];
  };

  # Configure libinput
  services.libinput.touchpad = {
    disableWhileTyping = true;
  };

  # Enable i3 window manager
  services.xserver = {
    windowManager.i3.enable = true;
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };
}
