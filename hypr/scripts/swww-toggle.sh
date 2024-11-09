
# Check if swww is active
if pgrep -x "swww-daemon" > /dev/null; then
    swww kill
else
    swww-daemon &
fi

