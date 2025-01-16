{ pkgs, lib, userSettings, ... }:

{
    imports = [
        ./modules/zsh.nix
        ./modules/qemu.nix
        (import ./modules/docker.nix {storageDriver = null; inherit pkgs userSettings lib;} )
    ];
}
