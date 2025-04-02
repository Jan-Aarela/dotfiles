# Allows only movewindoworgroup command in tiled mode. 

# 1st variable. 
# Example command: sh move_window.sh "l" 
# Where letter l, is the 1st variable.
DIRECTION=$1

# Checks if an active window is a floating one.
MODE=$(hyprctl activewindow -j | jq '.floating')
  
if [[ "$MODE" == "false" ]]; then
  case $DIRECTION in
     l)  hyprctl dispatch movewindoworgroup l;;
     r)  hyprctl dispatch movewindoworgroup r;;
     u)  hyprctl dispatch movewindoworgroup u;;
     d)  hyprctl dispatch movewindoworgroup d;;
  esac
fi

