{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }:
let
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1

  '';
in
{
  imports = [];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [];
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun"; 

      monitor = [
        "HDMI-A-1,1920x1080@119.77,0x0,1"
        "eDP-1,1920x1080@120.21,1920x0,1"
      ];

      # General window behavior
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee)";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      # Add basic input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
      };

      # Add window rules for better behavior
      windowrule = [
        "float,^(pavucontrol)$"
        "float,^(wofi)$"
      ];

      bind = [
        # Basic bindings
        "$mod, Return, exec, $terminal"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, D, exec, $menu"
        "$mod SHIFT, l, exec, hyprlock"
        "$mod SHIFT, R, exec, hyprctl reload"
        "$mod SHIFT, D, exec, hyprctl keyword monitor eDP-1,disable"  # Fixed syntax
        "$mod SHIFT, F, exec, hyprctl keyword monitor eDP-1,enable"   # Fixed syntax
        ", Print, exec, hyprshot -m window"
        "SHIFT, Print, exec, hyprshot -m region"  # Normalized SHIFT notation
        "$mod, P, pseudo"
        "$mod, E, togglesplit"
        "$mod, F, fullscreen"
        "$mod, W, togglegroup"
        
        # Focus bindings
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        
        # Workspace bindings
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move to workspace bindings
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Special workspace bindings
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
        
        # Mouse wheel workspace switching
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        
        # Media keys
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        
        # Brightness controls
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Add dwindle layout configuration
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
    };

    # Add startup commands
    systemd = {
      enable = true;
      extraCommands = [
        "${startupScript}/bin/start"
      ];
    };
  };

  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = if (config.stylix.polarity == "light") then "Quintom_Ink" else "Quintom_Snow";
    size = 36;
  };

  home.packages = with pkgs; [
    hyprpaper
    waybar
    swww
    wofi
    hyprlock
    wlsunset
    feh
    pavucontrol
    grim
    hyprshot    # Added missing dependency
    brightnessctl # Added missing dependency
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    # Add startup script to packages
    startupScript
  ];
}