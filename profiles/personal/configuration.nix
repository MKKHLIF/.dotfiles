{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  imports = [

    #bootloader
    ../../system/bootloader/grub.nix

    # hardware
    ../../system/hardware-configuration.nix
    ../../system/hardware/network.nix
    ../../system/hardware/audio.nix
    ../../system/hardware/nvidia.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/printing.nix
    
    # security
    ../../system/security/firewall.nix
    
    # display-manager
    ../../system/display-manager/sddm.nix
    
    # display-server & wm
    ../../system/wm/hyprland.nix
    ../../system/wm/qtile.nix
    
    # shell
    ../../system/shell/sh.nix

    # pkg
    ../../system/pkg/pkg.nix
    
    # app
    ../../system/app/flatpak.nix
    ../../system/app/virtualization.nix
    ( import ../../system/app/docker.nix {storageDriver = null; inherit pkgs userSettings lib;} )

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
