{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    # Configure Alacritty
    settings = {
      # Font settings
      font = {
        # family = "Hack";  # Replace with your preferred font
        size = 12.0;
      };

      # Window appearance
      window = {
        opacity = 0.9;      # Set window transparency
        decorations = "full";  # Options: full, none, buttonless
      };

      # Color scheme
      colors = {
        primary = {
          background = "#282c34"; # Background color
          foreground = "#abb2bf"; # Text color
        };

        normal = {
          black = "#282c34";
          red = "#e06c75";
          green = "#98c379";
          yellow = "#e5c07b";
          blue = "#61afef";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#dcdfe4";
        };

        bright = {
          black = "#5c6370";
          red = "#e06c75";
          green = "#98c379";
          yellow = "#e5c07b";
          blue = "#61afef";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#ffffff";
        };
      };

      # Scrolling settings
      # scrollback = 10000;

      # Other options
      cursor = {
        style = "Block";  # Options: Block, Underline, Beam
      };
    };
  };

  # Optionally, include Alacritty in the PATH
  home.packages = [
    pkgs.alacritty
  ];
}
