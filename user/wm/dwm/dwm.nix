{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }: let
in
{
    imports = [
      ../../app/terminal/st/st.nix
    ];

  nixpkgs = {
    overlays = [
      (final : prev : {
        dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
          configFile = prev.writeText "dwm-config.h" (import ./overlays/dwm-config.nix { inherit config; } );
          postPatch = ''
            ${oldAttrs.postPatch}
            cp ${configFile} config.def.h
          '';
        });

      })
    ];
  };
    
    home.packages = (with pkgs; [
        dwm
        dmenu
        xorg.xrandr
        slock
    ]);
}