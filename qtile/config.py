#   ==================== imports ====================
from libqtile import hook
import os
import subprocess

#   ==================== keybindings ====================
from keybindings import *

#   ==================== layouts ====================
from layouts import layouts

#   ==================== screens ====================
from screens import screens

#   ==================== rules ====================
from rules import *

#   ==================== hooks ====================
@hook.subscribe.startup_once
def autostart():
   home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
   subprocess.run([home])
