{
  description = "Flake of MK";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; 
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let

      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

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
        font = "Intel One Mono"; 
        fontPkg = pkgs.intel-one-mono;
      };

      inputs = {
        hyprland = {
          url = "github:hyprwm/Hyprland/v0.44.1?submodules=true";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      };

    in {
      
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
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
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix") # load home.nix from selected PROFILE

          ];
          
          extraSpecialArgs  = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
          
        };
      };
    };
}
