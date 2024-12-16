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

  ];

  
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;
  
  
  # Enable GNOME desktop environment
services.xserver.desktopManager.gnome.enable = true;
services.xserver.displayManager.gdm.enable = true;
# Optionally, ensure X server is enabled (usually done by default with GNOME)
services.xserver.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  
   fonts.packages = with pkgs; [
     (nerdfonts.override { fonts = [ "JetBrainsMono" "DroidSansMono" ]; })
   ];


  
   users.defaultUserShell = pkgs.zsh;
   environment.shells = with pkgs; [ zsh ];
   programs.zsh.enable = true;  


  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video"];
    packages = with pkgs; [
      vscode        
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    lshw
    htop
    neofetch
    git
    pciutils
    
    wineWowPackages.stable
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull
    
    gcc
    gdb
    cmake
    gnumake
    ninja
    zip
    unzip
    pkg-config
    virt-manager
  ];

  # Do not touch!
  system.stateVersion = "24.05";

}
