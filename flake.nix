{
  description = "Flake of MK";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    stylix.url = "github:danth/stylix";

  };

  outputs = inputs@{ self, ... }:
    let
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux";
        hostname = "mk";
        profile = "personal";
        timezone = "Africa/Tunis";
        locale = "en_US.UTF-8";
      };

      # ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "mk";
        name = "mk";
        email = "khlif.mk@proton.me";
        dotfilesDir = "~/.dotfiles";
        theme = "io";
        wm = "gruvbox-dark-hard";      # [dwm, hyprland, none]
        font = "Jetbrains Mono";
        fontPkg = pkgs.jetbrains-mono;
      };

      # configure lib
      lib = inputs.nixpkgs.lib;

      # configure pkgs
      pkgs = import inputs.nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      home-manager = inputs.home-manager;

    in {
      nixosConfigurations = {
        mk = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };
      };

      homeConfigurations = {
        mk = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
          ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };
      };
    };
}