from libqtile.lazy import lazy
from libqtile.config import Key, Click, Drag

from variables import *

keys = [
    # Open terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    
    # Qtile System Actions
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile. In X11, it won't close your windows."),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    
    # Active Window Actions
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    # Window Resize
    Key([mod, "control"], "h", lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio(), lazy.layout.delete()),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio(), lazy.layout.delete()),
    Key([mod, "control"], "l", lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio(), lazy.layout.add()),
    Key([mod, "control"], "Left", lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio(), lazy.layout.add()),
    Key([mod, "control"], "k", lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster()),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster()),
    Key([mod, "control"], "j", lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster()),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster()),

    # Window Focus (Arrows and Vim keys)
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # Move windows around MonadTall/MonadWide Layouts
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

    # Qtile Layout Actions
    Key([mod], "r", lazy.layout.reset()),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "space", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Switch focus to specific monitor (out of three)
    

    # Switch focus of monitors

    # launch 
   Key([mod], "d", lazy.spawn("dmenu_run")),
]

from groups import *

# Add group specific keybindings
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Mod + number to move to that group."),
        Key(["mod1"], "Tab", lazy.screen.next_group(), desc="Move to next group."),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group(), desc="Move to previous group."),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name), desc="Move focused window to new group."),
    ])


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]