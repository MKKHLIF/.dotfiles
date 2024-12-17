{ pkgs, lib, ... }: 

{
  # Import wayland config
    imports = [ ../display-server/wayland.nix ];

  # Security
  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
  };

  services.xserver.excludePackages = [ pkgs.xterm ];
  
}
