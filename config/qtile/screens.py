from libqtile.config import Screen
from libqtile import bar, widget
import os
from libqtile import qtile

soft_sep = {'linewidth': 2, 'size_percent': 70,
            'foreground': '393939', 'padding': 7}

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.Sep(**soft_sep),
                widget.GroupBox(),
                widget.Prompt(),
                widget.Sep(**soft_sep),
                widget.WindowName(),
                widget.Sep(**soft_sep),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                #widget.StatusNotifier(),
                #widget.Systray(),
                widget.Clock(format='%Y-%m-%d %H:%M %p'),
                widget.Sep(**soft_sep),
                widget.Battery(foreground='#247052', low_percentage=0.20, low_foreground='fa5e5b', update_delay=10, format='{percent:.0%}', charge_char='x'),
                widget.Sep(**soft_sep),
                widget.Net(interface = "enp47s0",),
                widget.Sep(**soft_sep),
                widget.Volume(foreground='#ADD8E6'),
                widget.Sep(**soft_sep),
                widget.Backlight(
                    foreground='#ffff00',
                    backlight_name = "intel_backlight",
                    brightness_file = "/sys/class/backlight/intel_backlight/actual_brightness",
                    max_brightness_file = "/sys/class/backlight/intel_backlight/max_brightness",
                    step = 10,
                    scroll = True,
                    scroll_fixed_width = True
                ),
                widget.Sep(**soft_sep),
                widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

