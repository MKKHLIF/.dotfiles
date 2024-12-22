{ inputs, config, lib, pkgs, userSettings, systemSettings, pkgs-nwg-dock-hyprland, ... }: let
in
{
    imports = [

    ];
    
    home.packages = (with pkgs; [
        dwm
        st
        dmenu
        xorg.xrandr
        slock
    ]);
}