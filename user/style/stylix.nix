{ config, lib, pkgs, inputs, userSettings, ... }:

let
  # Path to the theme configuration file (.yaml) based on the user-selected theme.
  themePath = "../../../themes" + ("/" + userSettings.theme + "/" + userSettings.theme) + ".yaml";

  # Read the polarity (light/dark) from the theme's polarity.txt file.
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes" + ("/" + userSettings.theme) + "/polarity.txt"));

  # URL of the background image for the theme, read from backgroundurl.txt.
  backgroundUrl = builtins.readFile (./. + "../../../themes" + ("/" + userSettings.theme) + "/backgroundurl.txt");

  # SHA256 checksum for the background image, read from backgroundsha256.txt.
  backgroundSha256 = builtins.readFile (./. + "../../../themes" + ("/" + userSettings.theme) + "/backgroundsha256.txt");
in
{
  # Import the stylix module for home-manager-based theming.
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  # Set the current theme in the user's home directory (for reference or tracking).
  home.file.".currenttheme".text = userSettings.theme;

  # Disable automatic enabling of stylix, we will configure it manually.
  stylix.autoEnable = false;

  # Set the polarity (light/dark theme) based on the user's selected theme.
  stylix.polarity = themePolarity;

  # Fetch the background image using its URL and verify its integrity with the SHA256 hash.
  stylix.image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };

  # Set the theme color scheme from the selected theme's YAML file.
  stylix.base16Scheme = ./. + themePath;

  # Configure fonts for the theme, using user-selected fonts for different categories (monospace, serif, sans-serif, emoji).
  stylix.fonts = {
    monospace = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    serif = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    sansSerif = {
      name = userSettings.font;
      package = userSettings.fontPkg;
    };
    emoji = {
      name = "Noto Emoji";  # Noto Emoji font for emoji support.
      package = pkgs.noto-fonts-monochrome-emoji;
    };
    # Define font sizes for different UI components (terminal, applications, etc.).
    sizes = {
      terminal = 18;  # Font size for terminal
      applications = 12;  # Font size for general applications
      popups = 12;  # Font size for popups
      desktop = 12;  # Font size for desktop icons or other desktop UI elements
    };
  };

  # Disable auto configuration for Alacritty, as we'll set it manually.
  stylix.targets.alacritty.enable = false;

  # Manually configure Alacritty's color scheme (since v3.0 broke the automatic configuration).
  programs.alacritty.settings = {
    colors = {
      # Map Alacritty's color scheme to the colors defined in stylix.
      primary.background = "#" + config.lib.stylix.colors.base00;
      primary.foreground = "#" + config.lib.stylix.colors.base07;
      cursor.text = "#" + config.lib.stylix.colors.base00;
      cursor.cursor = "#" + config.lib.stylix.colors.base07;
      normal.black = "#" + config.lib.stylix.colors.base00;
      normal.red = "#" + config.lib.stylix.colors.base08;
      normal.green = "#" + config.lib.stylix.colors.base0B;
      normal.yellow = "#" + config.lib.stylix.colors.base0A;
      normal.blue = "#" + config.lib.stylix.colors.base0D;
      normal.magenta = "#" + config.lib.stylix.colors.base0E;
      normal.cyan = "#" + config.lib.stylix.colors.base0B;
      normal.white = "#" + config.lib.stylix.colors.base05;
      bright.black = "#" + config.lib.stylix.colors.base03;
      bright.red = "#" + config.lib.stylix.colors.base09;
      bright.green = "#" + config.lib.stylix.colors.base01;
      bright.yellow = "#" + config.lib.stylix.colors.base02;
      bright.blue = "#" + config.lib.stylix.colors.base04;
      bright.magenta = "#" + config.lib.stylix.colors.base06;
      bright.cyan = "#" + config.lib.stylix.colors.base0F;
      bright.white = "#" + config.lib.stylix.colors.base07;
    };
    font.size = config.stylix.fonts.sizes.terminal;  # Use the terminal font size defined earlier.
    font.normal.family = userSettings.font;  # Set the font family to the user's selected font.
  };

  # Enable additional stylix targets for other applications (Kitty, GTK, etc.).
  stylix.targets.kitty.enable = true;
  stylix.targets.gtk.enable = true;

  # Enable Rofi and Feh only if using the X11 window manager.
  # stylix.targets.rofi.enable = if (userSettings.wmType == "x11") then true else false;
  # stylix.targets.feh.enable = if (userSettings.wmType == "x11") then true else false;

  # Enable Feh program to manage wallpaper settings.
  programs.feh.enable = true;

  # Create a script to set the background image using `feh`.
  home.file.".fehbg-stylix".text = ''
    #!/bin/sh
    feh --no-fehbg --bg-fill '' + config.stylix.image + '';
  '';
  # Make the background script executable.
  home.file.".fehbg-stylix".executable = true;

  # Define configuration files for Qt and KDE, using Stylix for color scheme injection.
  home.file = {
    ".config/qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
      template = builtins.readFile ./oomox-current.conf.mustache;
      extension = ".conf";
    };
    ".config/Trolltech.conf".source = config.lib.stylix.colors {
      template = builtins.readFile ./Trolltech.conf.mustache;
      extension = ".conf";
    };
    ".config/kdeglobals".source = config.lib.stylix.colors {
      template = builtins.readFile ./Trolltech.conf.mustache;
      extension = "";
    };
    ".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ./qt5ct.conf);
  };

  # Configure wallpaper settings for Hyprland (or Hypr) window manager.
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = '' + config.stylix.image + '';
    wallpaper = ,'' + config.stylix.image + '';
  '';

  # Install necessary packages for Qt5, Breeze icons, and Noto Emoji font.
  home.packages = with pkgs; [
    libsForQt5.qt5ct  # Qt5 configuration tool
    pkgs.libsForQt5.breeze-qt5  # Breeze theme for Qt5 applications
    libsForQt5.breeze-icons  # Breeze icon theme
    pkgs.noto-fonts-monochrome-emoji  # Noto Emoji font package
  ];

  # Configure Qt settings, using the Breeze dark theme and KDE as the platform theme.
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;  # Set Breeze theme for Qt5.
    style.name = "breeze-dark";  # Set the style to Breeze dark.
    platformTheme.name = "kde";  # Set the platform theme to KDE.
  };

  # Set the system's default fonts for monospace, sans-serif, and serif to the user's selected font.
  fonts.fontconfig.defaultFonts = {
    monospace = [ userSettings.font ];
    sansSerif = [ userSettings.font ];
    serif = [ userSettings.font ];
  };
}
