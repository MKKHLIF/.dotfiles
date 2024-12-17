{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    
    # hardware
    ../../system/hardware-configuration.nix
    ../../system/hardware/bootloader.nix
    ../../system/hardware/network.nix
    ../../system/hardware/time.nix
    ../../system/hardware/audio.nix
    ../../system/hardware/nvidia.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/printing.nix
    
    # app
    ../../system/app/flatpak.nix
    ../../system/app/virtualization.nix
    ( import ../../system/app/docker.nix {storageDriver = null; inherit pkgs userSettings lib;} )
    
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


  ];

  
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

  # Do not touch!
  system.stateVersion = "24.05";

}
