# settings/keys.py
from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy
from settings.path import terminal, browser, launcher, fileManager, editor, ntCenter

mod = "mod4"

keys = [
    # Window management
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    
    # Window movement
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    
    # Window resizing
    Key([mod, "control"], "j", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod, "control"], "k", lazy.layout.grow(), desc="Grow window"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    
    # Layout management
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle split"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "z", lazy.next_layout(), desc="Toggle between layouts"),
    
    # Window states
    Key([mod, "Shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating"),
    
    # System controls
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    
    # Applications
    Key([mod], "d", lazy.spawn(launcher), desc="App launcher"),
    Key([mod], "e", lazy.spawn(fileManager), desc="File manager"),
    Key([mod], "b", lazy.spawn(browser), desc="Browser"),
    Key([mod], "c", lazy.spawn(editor), desc="Editor"),
    Key([mod], "Tab", lazy.spawn(ntCenter), desc="Notification center"),
    
    # Screenshots
    Key([mod, "Shift"], "s", lazy.spawn("flameshot gui -c")),
    
    # Keyboard layout
    Key(["Shift"], "Tab", lazy.widget["keyboardlayout"].next_keyboard()),
    
    # Media controls
    Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-")),
    Key([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    Key([], "XF86AudioPlay", lazy.spawn('playerctl --player=spotify,%any play-pause')),
    Key([], "XF86AudioPrev", lazy.spawn('playerctl --player=spotify,%any previous')),
    Key([], "XF86AudioNext", lazy.spawn('playerctl --player=spotify,%any next')),
    
    # Virtual terminal mode
    KeyChord([mod], "i", [
        Key([mod], "i", lazy.ungrab_all_chords())],
        mode=True,
        name='Vm Mode',
    ),
]

# VT switching for Wayland
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )