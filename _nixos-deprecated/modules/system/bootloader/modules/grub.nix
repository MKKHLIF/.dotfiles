{ inputs, config, pkgs, lib, ... }:

{
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true; 

    boot.loader.grub2-theme = {
    enable = true;
    theme = "vimix";
    footer = true;
    customResolution = "1920x1080";  # Optional: Set a custom resolution
  };
}
