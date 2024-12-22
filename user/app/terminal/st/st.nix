{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }: let
in
{

  nixpkgs = {
    overlays = [
      (final : prev : {
        st = prev.st.overrideAttrs (oldAttrs: rec {
          configFile = prev.writeText "st-config.h" (import ./overlays/st-config.nix { inherit config; } );
          postPatch = ''
            ${oldAttrs.postPatch}
            cp ${configFile} config.def.h
          '';
        });
      })

    ];
  };
    
    home.packages = (with pkgs; [
        st
    ]);
}