{ pkgs, lib, ... }: 

{
  # Import wayland config
    imports = [ ../display-server/wayland.nix ];
    
}
