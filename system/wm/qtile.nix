{ pkgs, lib, ... }:

{
    imports = [ ./x11.nix ];
    
    services.xserver.windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
            qtile-extras
        ];
    };

}