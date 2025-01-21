{ pkgs, ... }:

{
  programs.fastfetch.enable = true;

  home.file = {
    ".config/fastfetch" = {
      source = ../../_config/fastfetch;
      recursive = true;
      force = true; # Ensures the folder is replaced as a symlink
    };
  };
}
