# settings/widgets.py
from libqtile import widget, qtile
from qtile_extras import widget as extra_widget
from qtile_extras.widget.decorations import PowerLineDecoration
from settings.path import terminal, browser
from theme import colors
import socket

widget_defaults = {
    "font": "JetBrains Mono Nerd Font Medium",
    "fontsize": 14,
    "padding": 3,
}

extension_defaults = widget_defaults.copy()

def powerline(direction):
    return {
        "decorations": [
            PowerLineDecoration(
                path=f"arrow_{direction}",
                use_widget_background=True
            )
        ]
    }

def init_widgets():
    # host = socket.gethostname()
    widgets = [
        widget.Spacer(length=2, **powerline("left")),
        widget.GroupBox(
            background=colors["base00"],
            fontsize=20,
            active=colors["base09"],
            inactive=colors["base03"],
            block_highlight_text_color="#FFFFFF",
            highlight_method="line",
            highlight_color=colors["base01"],
            this_current_screen_border=colors["base09"],
            urgent_alert_method="line",
            urgent_border=colors["base11"],
            disable_drag=True,
            **powerline("left")
        ),
        # ... (rest of your widgets)
    ]
    
    # if host != "laptop":
        # del widgets[-6]  # Remove battery widget for non-laptop devices
    
    return widgets