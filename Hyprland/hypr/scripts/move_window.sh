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

else
  case $DIRECTION in
     l)  hyprctl dispatch moveactive -$BIG 0 ;;
     r)  hyprctl dispatch moveactive $BIG 0 ;;
     u)  hyprctl dispatch moveactive 0 -$BIG ;;
     d)  hyprctl dispatch moveactive 0 $BIG ;;
     sl) hyprctl dispatch moveactive -$SMALL 0 ;;
     sr) hyprctl dispatch moveactive $SMALL 0 ;;
     su) hyprctl dispatch moveactive 0 -$SMALL ;;
     sd) hyprctl dispatch moveactive 0 $SMALL ;;
  esac
fi  

