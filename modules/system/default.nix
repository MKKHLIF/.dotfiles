{ config, lib, pkgs, systemSettings, userSettings, ... }:
let

in
{
  imports = [
    
    ./core/grub.nix               
    ./core/network.nix
    ./core/audio.nix             
    ./core/nvidia.nix            
    ./core/bluetooth.nix
    ./core/printing.nix         
    ./core/firewall.nix          
    ./desktop/sddm.nix       
    ./desktop/x11/x11.nix    
    ./stylix/stylix.nix
    ./app/pkgs.nix                   
    ./app/zsh.nix                   
    ./app/qemu.nix
    ( import ./app/docker.nix {storageDriver = null; inherit pkgs userSettings lib;} )

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
