# settings/screens.py
from libqtile import bar
from libqtile.config import Screen
from settings.widgets import init_widgets
from settings.path import PATH
import os

def init_screens():
    return [
        Screen(
            # wallpaper = os.path.expanduser("~/Dotfiles/wallpapers/main.jpg"),
            # wallpaper_mode = "fill",
            top=bar.Bar(
                init_widgets(),
                24,
                background = colors["base01"],
                reserve = True
            ),
        ),
    ]

screens = init_screens()