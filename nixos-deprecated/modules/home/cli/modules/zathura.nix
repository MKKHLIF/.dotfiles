{ pkgs, ... }:

{
  programs.zathura.enable = true;

  home.file = {
    ".config/zathura" = {
      source = ../../_config/zathura;
      recursive = true;
      force = true; # Ensures the folder is replaced as a symlink
    };
  };
}
