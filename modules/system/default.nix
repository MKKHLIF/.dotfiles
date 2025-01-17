{ config, lib, pkgs, systemSettings, userSettings, ... }:
let

in
{
  imports = [
    
    ./hardware
    ./bootloader
    ./display-server
    ./display-manager
    ./services
    ./security
    ./networking
    ./apps


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

  environment.systemPackages = with pkgs; [
    vim
    wget
    lshw
    htop
    neofetch
    git
    pciutils
    zip
    unzip
  ];


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
