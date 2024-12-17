{ ... }:

{
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  
    boot.supportedFilesystems = [ "ntfs" ];
    boot.loader.systemd-boot.configurationLimit = 8;
}
