{ pkgs, userSettings, ... }:
let
  enableDwm = userSettings.wm == "dwm";
in
{
  imports = [ ./utils/dbus.nix
              ./utils/gnome-keyring.nix
              ./utils/fonts.nix
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
  services.libinput.touchpad.disableWhileTyping = true;

  # securtiy
  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;

  services.xserver.windowManager.dwm.enable = enableDwm;

}