import os
import subprocess
import socket
from libqtile import hook, qtile
from libqtile import bar, layout, qtile, widget

# Variables
mod = "mod4"
host = socket.gethostname()
terminal = "kitty"
browser = "brave"
launcher = "rofi -show drun"
fileManager = "thunar"
editorOne = "code"
editorTwo = "nvim"
