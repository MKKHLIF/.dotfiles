{ pkgs, ... }:
{
    home.packages = [
        pkgs.tmux
        pkgs.discord
        pkgs.anki
        pkgs.obsidian
        pkgs.telegram-desktop
  ];

}