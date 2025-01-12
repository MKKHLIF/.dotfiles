{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }:
let
in
{
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

      # Colors configuration
      colors = {
        background = "#2E3440";
        focused = {
          border = "#88C0D0";
          background = "#88C0D0";
          text = "#2E3440";
          indicator = "#A3BE8C";
          childBorder = "#88C0D0";
        };
        unfocused = {
          border = "#3B4252";
          background = "#3B4252";
          text = "#D8DEE9";
          indicator = "#3B4252";
          childBorder = "#3B4252";
        };
        urgent = {
          border = "#BF616A";
          background = "#BF616A";
          text = "#D8DEE9";
          indicator = "#BF616A";
          childBorder = "#BF616A";
        };
      };

      # Bar configuration using i3status-rust
      bars = [
        {
          position = "bottom";
          statusCommand = "i3status-rust ~/.config/i3status-rust/config-default.toml";
          colors = {
            background = "#2E3440";
            statusline = "#D8DEE9";
            separator = "#4C566A";
            focusedWorkspace = {
              border = "#88C0D0";
              background = "#88C0D0";
              text = "#2E3440";
            };
            activeWorkspace = {
              border = "#4C566A";
              background = "#4C566A";
              text = "#D8DEE9";
            };
            inactiveWorkspace = {
              border = "#3B4252";
              background = "#3B4252";
              text = "#D8DEE9";
            };
            urgentWorkspace = {
              border = "#BF616A";
              background = "#BF616A";
              text = "#D8DEE9";
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
        "${modifier}+q" = "kill";
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
        # "${modifier}+0" = "workspace number 0";

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
        # "${modifier}+Shift+0" = "move container to workspace number 0";

        # Layout
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        # Enable / Disable eDP-1
        "${modifier}+Ctrl+d" = "exec xrandr --output eDP-1 --off";
        "${modifier}+Ctrl+f" = "exec xrandr --output eDP-1 --mode 1920x1080 --rate 120.17 --pos 1920x0";
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
      sleep 2 && exec --no-startup-id xrandr --output HDMI-1-1 --mode 1920x1080 --rate 119.93 --pos 0x0 --primary --output eDP-1 --mode 1920x1080 --rate 120.17 --pos 1920x0
    '';
  };

}
