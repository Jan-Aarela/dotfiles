# If a group, moves group in a direction.
# Else moves floating window in a direction.

# 1st variable. 
# Example command: sh move_window.sh "l" 
# Where letter l, is the 1st variable.
DIRECTION=$1

# Move amount for floating window.
BIG=200
SMALL=50 

# Checks if an active window is a floating one.
TYPE=$(hyprctl activewindow -j | jq '.floating')

if [[ "$TYPE" == "false" ]]; then
  hyprctl dispatch movewindow $DIRECTION  

elif [[ "$DIRECTION" == "l" ]]; then
  hyprctl dispatch moveactive -$BIG 0
elif [[ "$DIRECTION" == "r" ]]; then
  hyprctl dispatch moveactive $BIG 0
elif [[ "$DIRECTION" == "u" ]]; then
  hyprctl dispatch moveactive 0 -$BIG
elif [[ "$DIRECTION" == "d" ]]; then
  hyprctl dispatch moveactive 0 $BIG

elif [[ "$DIRECTION" == "sl" ]]; then
  hyprctl dispatch moveactive -$SMALL 0
elif [[ "$DIRECTION" == "sr" ]]; then
  hyprctl dispatch moveactive $SMALL 0
elif [[ "$DIRECTION" == "su" ]]; then
  hyprctl dispatch moveactive 0 -$SMALL
elif [[ "$DIRECTION" == "sd" ]]; then
  hyprctl dispatch moveactive 0 $SMALL
fi  

