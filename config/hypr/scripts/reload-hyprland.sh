
# Path to your main Hyprland configuration file
CONFIG_FILE="$HOME/.config/hypr/configs/monitors.conf"

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found at $CONFIG_FILE."
    exit 1
fi

# Comment out the first line
sed -i '1 s/^/# /' "$CONFIG_FILE"
echo "Commented out the first line."

# Wait for 50 milliseconds
sleep 1

# Uncomment the first line
sed -i '1 s/^# //' "$CONFIG_FILE"
echo "Uncommented the first line."

echo "monitors configuration reload triggered."

