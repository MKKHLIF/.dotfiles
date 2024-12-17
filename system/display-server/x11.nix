{ pkgs, ... }:

{
  imports = [ ./utils/dbus.nix
              ./utils/gnome-keyring.nix
              ./utils/fonts.nix
            ];

  # Configure X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    excludePackages = [ pkgs.xterm ];
    libinput = {
      touchpad.disableWhileTyping = true;
    };
  };
}