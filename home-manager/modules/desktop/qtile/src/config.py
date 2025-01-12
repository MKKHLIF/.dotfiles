# config.py
import os
import subprocess
import socket
from libqtile import hook, qtile
from settings.keys import keys
from settings.groups import groups
from settings.layouts import layouts, floating_layout
from settings.screens import screens
from settings.mouse import mouse
from settings.path import PATH

# Set backend
if qtile.core.name == "wayland":
    os.environ["XDG_SESSION_TYPE"] = "wayland"
    os.environ["XDG_SESSION_DESKTOP"] = "qtile:wlroots"
    os.environ["XDG_CURRENT_DESKTOP"] = "qtile:wlroots"

# Startup hook
@hook.subscribe.startup_once
def autostart():
    subprocess.Popen([os.path.join(PATH, 'scripts/autostart.sh')])

# Other configurations
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = True
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "QTILE"

# Wayland specific settings
wl_input_rules = {
    "type:pointer": InputConfig(accel_profile="flat"),
}
wl_xcursor_theme = "Nordzy-cursors"
wl_xcursor_size = 24