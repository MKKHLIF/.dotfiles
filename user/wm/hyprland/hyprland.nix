{ inputs, config, lib, pkgs, userSettings, systemSettings, pkgs-nwg-dock-hyprland, ... }: let
    pkgs-hyprland = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
    imports = [
        ../../app/terminal/kitty.nix
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