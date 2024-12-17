{ inputs, config, lib, pkgs, userSettings, systemSettings, pkgs-nwg-dock-hyprland, ... }: let
    pkgs-hyprland = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
    imports = [
        ../../app/terminal/kitty.nix
    ];

}