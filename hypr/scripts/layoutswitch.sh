# Checks the current layout, and then switches to other one.

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

if [[ "$LAYOUT" == "dwindle" ]]; then
  hyprctl keyword general:layout "master"
  notify-send -t 666 "Layout - MASTER"
else
  hyprctl keyword general:layout "dwindle"
  notify-send -t 666 "Layout - DWINDLE"
fi

