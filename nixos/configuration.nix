{ config, lib, pkgs, systemSettings, userSettings, ... }:
let

in
{
  imports = [
    
    # Hardware Configuration
    ./hardware-configuration.nix

     # Core System Modules
    ./modules/core/grub.nix               
    ./modules/core/network.nix
    ./modules/core/audio.nix             
    ./modules/core/nvidia.nix            
    ./modules/core/bluetooth.nix
    ./modules/core/printing.nix         
    ./modules/core/firewall.nix          
    
    # Desktop Environment
    ./modules/desktop/sddm.nix       
    ./modules/desktop/x11/x11.nix    


    # Stylix
    ./modules/stylix/stylix.nix

    # App Modules
    ./modules/app/pkgs.nix                   
    ./modules/app/zsh.nix                   
    ./modules/app/qemu.nix
    ( import ./modules/app/docker.nix {storageDriver = null; inherit pkgs userSettings lib;} )

  ];

  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };
  

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;
  
  
  # TO DELETE: Enable GNOME desktop environment
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video"];
    packages = with pkgs; [
      vscode
       
    ];
  };

  # use a custom font directory for storing and loading fonts.
  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Do not touch!
  system.stateVersion = "24.05";

}
