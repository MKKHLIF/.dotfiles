{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }:
let

in
{

  home.file = {
    ".config/i3/scripts" = {
      source = ../../_config/i3/scripts;
      recursive = true;
      force = true; # Ensures the folder is replaced as a symlink
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      # Use Super/Windows key as modifier
      modifier = "Mod4";

      # Default terminal and menu
      terminal = "alacritty";
      menu = "rofi -show drun";

      # Default settings for gaps
      gaps = {
        inner = 5;
        outer = 3;
        smartGaps = true;
        smartBorders = "on";
      };

      # Window borders and titlebar settings
      window = {
        border = 2;
        titlebar = true;
        hideEdgeBorders = "smart";
        commands = [
          {
            command = "border pixel 2";
            criteria = { class = "^.*"; };
          }
        ];
      };

      # Colors configuration using Gruvbox Dark
      colors = {
        background = "#1d2021";  # base00
        focused = {
          border = "#b8bb26";      # base0B (green)
          background = "#b8bb26";   # base0B (green)
          text = "#1d2021";        # base00 (bg)
          indicator = "#8ec07c";    # base0C (aqua)
          childBorder = "#b8bb26";  # base0B (green)
        };
        unfocused = {
          border = "#3c3836";      # base01
          background = "#3c3836";   # base01
          text = "#d5c4a1";        # base05
          indicator = "#3c3836";    # base01
          childBorder = "#3c3836";  # base01
        };
        urgent = {
          border = "#fb4934";      # base08 (red)
          background = "#fb4934";   # base08 (red)
          text = "#fbf1c7";        # base07
          indicator = "#fb4934";    # base08 (red)
          childBorder = "#fb4934";  # base08 (red)
        };
      };

      # Bar configuration using i3status-rust with Gruvbox colors
      bars = [
        {
          position = "bottom";
          statusCommand = "i3status-rust ~/.config/i3status-rust/config-default.toml";
          colors = {
            background = "#1d2021";  # base00
            statusline = "#ebdbb2";  # base06
            separator = "#504945";   # base02
            focusedWorkspace = {
              border = "#b8bb26";    # base0B (green)
              background = "#b8bb26"; # base0B (green)
              text = "#1d2021";      # base00
            };
            activeWorkspace = {
              border = "#504945";    # base02
              background = "#504945"; # base02
              text = "#ebdbb2";      # base06
            };
            inactiveWorkspace = {
              border = "#3c3836";    # base01
              background = "#3c3836"; # base01
              text = "#d5c4a1";      # base05
            };
            urgentWorkspace = {
              border = "#fb4934";    # base08 (red)
              background = "#fb4934"; # base08 (red)
              text = "#fbf1c7";      # base07
            };
          };
          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
            size = 8.0;
          };
        }
      ];

      # Basic key bindings
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in {
        "${modifier}+Return" = "exec ${config.xsession.windowManager.i3.config.terminal}";
        "${modifier}+d" = "exec ${config.xsession.windowManager.i3.config.menu}";
        "${modifier}+c" = "kill";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Exit i3?' -B 'Yes' 'i3-msg exit'";

        # Focus
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        # Move
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        # Move containers to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Layout
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        # Enable / Disable HDMI-1-1 / eDP-1
        "${modifier}+Ctrl+d" = "exec ~/.config/i3/scripts/display-manager.sh edp-off";
        "${modifier}+Ctrl+f" = "exec ~/.config/i3/scripts/display-manager.sh edp-on";
        "${modifier}+Shift+d" = "exec ~/.config/i3/scripts/display-manager.sh hdmi-off";
        "${modifier}+Shift+f" = "exec ~/.config/i3/scripts/display-manager.sh hdmi-on";

        "${modifier}+Shift+x" = "exec ~/.config/i3lock/lock.sh";
      };

      # Startup applications
      startup = [
        # {
        #   command = "picom -b";
        #   always = true;
        #   notification = false;
        # }
        # {
        #   command = "nitrogen --restore";
        #   always = true;
        #   notification = false;
        # }
        # {
        #   command = "dunst";
        #   notification = false;
        # }
      ];

      # Focus settings
      focus = {
        followMouse = true;
        mouseWarping = true;
        newWindow = "smart";
        wrapping = "yes";
      };

      # Font settings
      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        size = 10.0;
      };

      # Workspace settings
      workspaceLayout = "default";
      workspaceAutoBackAndForth = true;
    };

    # Extra configuration
    extraConfig = ''
      exec --no-startup-id ~/.config/i3/scripts/display-init.sh
      exec --no-startup-id nitrogen --restore
    '';
  };
}