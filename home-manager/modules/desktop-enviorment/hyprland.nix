{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }: 
let

in
{
    imports = [
    ];

    home.packages = (with pkgs; [
        hyprpaper
        wofi
        
        wlsunset
        feh
        pavucontrol
        grim

        qt6.qtwayland

        xdg-utils
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
    ]);
}