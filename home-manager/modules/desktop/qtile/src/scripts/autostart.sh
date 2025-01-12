#!/bin/bash

# Set up screens with appropriate resolution, refresh rate, and positions
xrandr --output HDMI-1-1 --mode 1920x1080 --rate 119.93 --pos 0x0 --primary \
       --output eDP-1 --mode 1920x1080 --rate 120.17 --pos 1920x0
