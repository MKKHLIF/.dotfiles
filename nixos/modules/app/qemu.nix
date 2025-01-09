{ config, pkgs, userSettings, ... }:

{
  environment.systemPackages = with pkgs; [ virt-manager distrobox ];
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
  virtualisation.waydroid.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];

}
