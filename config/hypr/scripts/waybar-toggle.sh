
# Check if waybar is active
if pgrep -x ".waybar-wrapped" > /dev/null; then
    pkill .waybar-wrapped 
else
    waybar &
fi

