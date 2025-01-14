{ ... }:
let

in
{
    imports = [
        ./hardware-configuration.nix
        ../../modules/system/default.nix
    ];
}