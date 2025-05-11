# Checks the current layout, switches the layout and sends a notification.

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

if [[ "$LAYOUT" == "dwindle" ]]; then
  hyprctl keyword general:layout "master"
  notify-send "MASTER"
else
  hyprctl keyword general:layout "dwindle"
  notify-send "DWINDLE"
fi
