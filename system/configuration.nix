{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.supportedFilesystems = [ "ntfs" ];

  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Tunis";
  i18n.defaultLocale = "en_US.UTF-8";
  
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;
  
  hardware.graphics.enable = true;
  hardware.nvidia = {
    prime = { 
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };    
      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };   

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];


  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    desktopManager = {
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
	      i3status
        i3lock
        i3blocks 
      ];
    };
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "none+i3";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
     jack.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  
   fonts.packages = with pkgs; [
     (nerdfonts.override { fonts = [ "JetBrainsMono" "DroidSansMono" ]; })
   ];

   networking.firewall.allowedTCPPorts = [ 57621 ];
   networking.firewall.allowedUDPPorts = [ 5353 ];
  
   users.defaultUserShell = pkgs.zsh;
   environment.shells = with pkgs; [ zsh ];
   programs.zsh.enable = true;  


   users.users.mk = {
     isNormalUser = true;
     extraGroups = [ "wheel" "libvirtd" "networkmanager" "video" "audio" "docker"];
     packages = with pkgs; [
      brave
      arandr
      vscode
      discord
      pavucontrol
      spotify
      telegram-desktop

      kitty
      wofi
      dolphin
      waybar
      swww

      wlsunset
      obsidian
      jetbrains-toolbox
      zathura
     ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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

    mangohud
    protonup
];

  programs.thunar.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; 
  
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers

  gamescopeSession.enable = true;
};

programs.gamemode.enable = true;

environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
