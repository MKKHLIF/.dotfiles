{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    lshw
    htop
    neofetch
    git
    pciutils
    
    zip
    unzip
  ];

}