{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nitrogen
  ];

  home.file = {
    ".config/nitrogen" = {
      source = ../../_config/nitrogen;
      recursive = true;
      force = true; # Ensures the folder is replaced as a symlink
    };
  };

}
