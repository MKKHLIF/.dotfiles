from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook
import subprocess

mod = "mod4"
terminal = "kitty"

@hook.subscribe.startup_once
def autostart():
    subprocess.run("xrandr --output eDP-1 --mode 1920x1080 --rate 120 --rotate normal --output HDMI-1-1 --primary --mode 1920x1080 --rate 120 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off", shell=True)
    subprocess.run("nitrogen --restore", shell=True)
    subprocess.run("picom &", shell=True)



def toggle_edp1(qtile):
    status = subprocess.getoutput("xrandr --listmonitors")
    if "eDP-1" in status:
        subprocess.run("xrandr --output eDP-1 --off", shell=True)
    else:
        subprocess.run("xrandr --output eDP-1 --mode 1920x1080 --rate 120 --right-of HDMI-1-1", shell=True)

def show_power_menu(qtile):
    """Show power menu using rofi with inline options"""
    power_options = [
        "shutdown",
        "reboot", 
        "sleep",
        "hibernate"
    ]
    
    options_str = "\\n".join(power_options)
    rofi_cmd = f'echo -e "{options_str}" | rofi -dmenu -p "Power:" -theme-str "window {{width: 20%;}}"'
    
    try:
        # Get user selection
        result = subprocess.check_output(rofi_cmd, shell=True, text=True).strip()
        
        # Execute the selected action
        if result == "shutdown":
            subprocess.run("systemctl poweroff", shell=True)
        elif result == "reboot":
            subprocess.run("systemctl reboot", shell=True)
        elif result == "sleep":
            subprocess.run("systemctl suspend", shell=True)
        elif result == "hibernate":
            subprocess.run("systemctl hibernate", shell=True)
    except subprocess.CalledProcessError:
        # User cancelled or no selection made
        pass

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Next window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Open terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Switch layout"),
    Key([mod], "c", lazy.window.kill(), desc="Close window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show drun -refresh-desktop-cache"), desc="Run launcher"),
    Key([mod], "d", lazy.spawn("rofi -show drun -refresh-desktop-cache"), desc="Run launcher"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod, "shift"], "d", lazy.function(toggle_edp1), desc="Toggle eDP-1"),
    Key([mod, "shift"], "q", lazy.function(show_power_menu), desc="Power menu"),

    # Brightness
    Key([mod], "F5", lazy.spawn("brightnessctl set 5%-"), desc="Brightness down"),
    Key([mod], "F6", lazy.spawn("brightnessctl set +5%"), desc="Brightness up"),

    # Volume
    Key([mod], "F1", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Mute"),
    Key([mod], "F2", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Volume down"),
    Key([mod], "F3", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Volume up"),
]

groups = [Group(i) for i in "123456789"]
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc=f"Switch to group {i.name}"),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name), desc=f"Send to group {i.name}"),
    ])

layouts = [
    layout.Columns(border_focus="#fabd2f", border_normal="#282828", border_width=2),
    layout.Max(),
]

widget_defaults = dict(
    font="Sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

colors = {
    "bg": "#282828",
    "fg": "#ebdbb2",
    "gray": "#a89984",
    "yellow": "#fabd2f",
    "blue": "#83a598",
    "green": "#b8bb26",
    "red": "#fb4934",
    "orange": "#fe8019",
}

def get_bluetooth_status():
    output = subprocess.getoutput("bluetoothctl show")
    if "Powered: yes" in output:
        return " ON"
    return " OFF"

def get_internet_status():
    # Check if default route exists (means connected)
    route = subprocess.getoutput("ip route show default")
    if not route:
        return "Disconnected"

    # Get default interface from route line
    default_iface = route.split()[4] if len(route.split()) > 4 else ""

    # Identify connection type
    if default_iface.startswith("wl"):  # wireless
        ssid = subprocess.getoutput("nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2").strip()
        return f"WiFi: {ssid}" if ssid else "WiFi: Connected"
    elif default_iface.startswith("en") or default_iface.startswith("eth"):  # ethernet
        return "Ethernet: Connected"
    else:
        return f"Connected ({default_iface})"

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    highlight_method="line",
                    this_current_screen_border=colors["yellow"],
                    inactive=colors["gray"],
                    active=colors["fg"],
                    background=colors["bg"],
                    disable_drag=True
                ),
                widget.Spacer(length=5),
                widget.Prompt(),
                widget.WindowName(foreground=colors["blue"]),
                widget.Spacer(),

                widget.TextBox(text="Net:", foreground=colors["green"]),
                widget.GenPollText(
                    func=get_internet_status,
                    update_interval=5,
                    foreground=colors["green"],
                    mouse_callbacks={"Button1": lazy.spawn("nm-connection-editor")}
                ),

                widget.TextBox(text=" | BT:", foreground=colors["blue"]),
                widget.GenPollText(
                    func=get_bluetooth_status,
                    update_interval=10,
                    foreground=colors["blue"],
                    mouse_callbacks={"Button1": lazy.spawn("blueman-manager")}
                ),

                widget.TextBox(text=" | CPU:", foreground=colors["red"]),
                widget.CPU(format="{load_percent}%", update_interval=2, foreground=colors["red"]),

                widget.TextBox(text=" | RAM:", foreground=colors["orange"]),
                widget.Memory(format="{MemUsed:.0f}M", update_interval=2, foreground=colors["orange"]),

                widget.TextBox(text=" | VOL:", foreground=colors["yellow"]),
                widget.Volume(fmt="{}", foreground=colors["yellow"], update_interval=1),

                widget.TextBox(text=" | BRI:", foreground=colors["blue"]),
                widget.Backlight(backlight_name="intel_backlight", format="{percent:2.0%}", foreground=colors["blue"]),

                widget.TextBox(text=" | BAT:", foreground=colors["green"]),
                widget.Battery(format="{percent:2.0%} {char}", foreground=colors["green"]),

                widget.TextBox(text=" |", foreground=colors["gray"]),
                widget.Clock(format="%a %b %d %H:%M", foreground=colors["fg"]),
                widget.Systray(),
            ],
            22,
            background=colors["bg"],
            margin=[2, 4, 0, 4],
        ),
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(title="Bluetooth Devices"),
        Match(title="Network Connections"),
    ]
)

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24
wmname = "LG3D"

# Dependencies:
# qtile kitty rofi xrandr nitrogen nmcli blueman pavucontrol acpi upower brightnessctl pulseaudio-utils bluez bluez-tools NetworkManager-applet 