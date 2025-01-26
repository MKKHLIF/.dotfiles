#!/bin/sh

# Function to check if a display is connected
check_display() {
    local display=$1
    xrandr | grep "^$display" | grep " connected" > /dev/null
}

# Function to check if a display is active
check_active() {
    local display=$1
    xrandr | grep "^$display" | grep "+0+" > /dev/null
}

# Function to safely toggle a display
toggle_display() {
    local display=$1
    local mode=$2
    local rate=$3
    local position=$4
    local primary=$5

    # Wait for any pending xrandr operations
    sleep 0.5

    if ! check_display "$display"; then
        echo "Display $display is not connected"
        return 1
    fi

    if [ "$mode" = "off" ]; then
        # Only turn off if active
        if check_active "$display"; then
            xrandr --output "$display" --off
            echo "Turned off $display"
        fi
    else
        primary_arg=""
        if [ "$primary" = "yes" ]; then
            primary_arg="--primary"
        fi
        
        xrandr --output "$display" --mode "$mode" --rate "$rate" --pos "$position" $primary_arg
        echo "Enabled $display"
    fi
}

# Main script
case "$1" in
    "edp-off")
        toggle_display "eDP-1" "off"
        toggle_display "HDMI-1-1" "1920x1080" "120.17" "0x0" "yes"
        ;;
    "edp-on")
        toggle_display "eDP-1" "1920x1080" "120.17" "1920x0" "no"
        ;;
    "hdmi-off")
        toggle_display "HDMI-1-1" "off"
        toggle_display "eDP-1" "1920x1080" "120.17" "0x0" "yes"
        ;;
    "hdmi-on")
        toggle_display "HDMI-1-1" "1920x1080" "120.17" "0x0" "yes"
        ;;
    *)
        echo "Usage: $0 {edp-off|edp-on|hdmi-off|hdmi-on}"
        exit 1
        ;;
esac