{ config, userSettings, pkgs, inputs, ... }:
let

in
{
  imports = [ 
    ./shared
    ./x11/x11.nix ];
 
}
