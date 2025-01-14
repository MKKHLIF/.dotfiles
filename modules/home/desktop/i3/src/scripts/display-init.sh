#!/bin/sh

# Maximum number of retries
MAX_RETRIES=5
# Wait time between retries (in seconds)
WAIT_TIME=1

# Function to check if a display is connected and ready
check_display() {
    local display=$1
    xrandr | grep "^$display" | grep " connected" > /dev/null
}

# Function to wait for displays to be ready
wait_for_displays() {
    local retry_count=0
    
    while [ $retry_count -lt $MAX_RETRIES ]; do
        if check_display "HDMI-1-1" && check_display "eDP-1"; then
            return 0
        fi
        echo "Waiting for displays to be ready... (attempt $((retry_count + 1)))"
        sleep $WAIT_TIME
        retry_count=$((retry_count + 1))
    done
    
    return 1
}

# Function to configure displays
configure_displays() {
    xrandr --output HDMI-1-1 --mode 1920x1080 --rate 119.93 --pos 0x0 --primary
    if [ $? -eq 0 ]; then
        xrandr --output eDP-1 --mode 1920x1080 --rate 120.17 --pos 1920x0
        return $?
    fi
    return 1
}

# Function to set wallpaper
set_wallpaper() {
    # Wait a moment for the displays to stabilize
    sleep 0.5
    nitrogen --restore
}

# Main execution
echo "Starting display configuration..."

if wait_for_displays; then
    echo "Displays detected, configuring..."
    if configure_displays; then
        echo "Display configuration successful"
        set_wallpaper
        echo "Wallpaper restored"
        exit 0
    else
        echo "Failed to configure displays"
        exit 1
    fi
else
    echo "Displays not ready after maximum retries"
    exit 1
fi