#!/usr/bin/env bash

# Gruvbox color palette
bg_dark='#282828'          # Dark background
red='#cc241d'             # Red
green='#98971a'           # Green
yellow='#d79921'          # Yellow
blue='#458588'            # Blue
fg='#ebdbb2'             # Light foreground
gray='#a89984'           # Gray

# Path to your background image
# Replace this with your actual image path
IMAGE_PATH="$HOME/.config/wallpapers/01.jpg"
RESIZED_IMAGE="/tmp/lock-resized.png"

# Check if required commands exist
for cmd in i3lock-color convert xrandr; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed"
        exit 1
    fi
done

# Check if image exists
if [ ! -f "$IMAGE_PATH" ]; then
    echo "Error: Background image not found at $IMAGE_PATH"
    exit 1
fi

# Get primary monitor resolution using xrandr
resolution=$(xrandr --query | grep ' primary ' | grep -o '[0-9]*x[0-9]*' | head -n1)
if [ -z "$resolution" ]; then
    # Fallback to first connected monitor if no primary is set
    resolution=$(xrandr --query | grep ' connected' | grep -o '[0-9]*x[0-9]*' | head -n1)
fi

# Extract width and height
width=$(echo $resolution | cut -d'x' -f1)
height=$(echo $resolution | cut -d'x' -f2)

# Resize image to match primary monitor resolution
convert "$IMAGE_PATH" -resize "${width}x${height}^" -gravity center -extent "${width}x${height}" "$RESIZED_IMAGE"

# Launch i3lock-color with custom settings
i3lock \
    --image="$RESIZED_IMAGE" \
    \
    --insidever-color=${green}     \
    --ringver-color=${green}       \
    \
    --insidewrong-color=${red}     \
    --ringwrong-color=${red}       \
    \
    --inside-color=${bg_dark}      \
    --ring-color=${blue}           \
    --line-color=${bg_dark}        \
    --separator-color=${bg_dark}    \
    \
    --verif-color=${fg}            \
    --wrong-color=${fg}            \
    --time-color=${fg}             \
    --date-color=${fg}             \
    --layout-color=${fg}           \
    --keyhl-color=${green}        \
    --bshl-color=${red}            \
    \
    --screen=1                     \
    --blur=5                       \
    --clock                        \
    --indicator                    \
    --time-str="%H:%M:%S"         \
    --date-str="%Y-%m-%d"         \
    --keylayout=1                  \
    \
    --time-font="JetBrains Mono"   \
    --date-font="JetBrains Mono"   \
    --layout-font="JetBrains Mono" \
    --verif-font="JetBrains Mono"  \
    --wrong-font="JetBrains Mono"  \
    \
    --time-size=32                 \
    --date-size=16                 \
    --layout-size=16               \
    --verif-size=24               \
    --wrong-size=24               \
    \
    --radius=120                   \
    --ring-width=8                 \
    --pass-media-keys             \
    --pass-screen-keys            \
    --pass-volume-keys

# Clean up temporary resized image
rm "$RESIZED_IMAGE"