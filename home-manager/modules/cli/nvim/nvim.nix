{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file = {
    ".config/nvim" = {
      source = ./nvim-config;
      recursive = true;
      force = true; # Ensures the folder is replaced as a symlink
    };
  };
}
