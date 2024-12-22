{ pkgs, lib, ... }: 

{
    # Import wayland config
    imports = [ ../display-server/x11.nix ];

    # Security
    security = {
    pam.services.login.enableGnomeKeyring = true;
    };

    services.gnome.gnome-keyring.enable = true;

    services.xserver.windowManager.dwm.enable = true;
    
}
