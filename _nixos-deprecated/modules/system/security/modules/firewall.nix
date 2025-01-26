{ ... }:

{
  # Firewall
  networking.firewall.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 57621 22000 21027 ]; # syncthing
  networking.firewall.allowedUDPPorts = [ 5353 22000 21027 ]; # syncthing

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
