# settings/layouts.py
from libqtile import layout
from libqtile.config import Match
from theme import colors

layout_theme = {
    "border_focus": colors["base09"],
    "border_normal": colors["base03"],
    "border_width": 2,
    "margin": 5,
}

layouts = [
    layout.MonadTall(**layout_theme),
]

floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)