# Perseestä

DIRECTION=$1

MODE=$(hyprctl activewindow -j | jq '.grouped')
FWINDOW=$(echo "$MODE" | jq -r '.[0]')
LWINDOW=$(echo "$MODE" | jq -r '.[-1]')
CURRENT=$(hyprctl activewindow -j | jq -r '.address')

if [[ "$MODE" == "[]" ]]; then
  hyprctl dispatch movefocus $DIRECTION

elif [[ "$DIRECTION" == "r" ]]; then
  if [[ "$CURRENT"  == "$LWINDOW" ]]; then 
    hyprctl dispatch movefocus r

  else hyprctl dispatch changegroupactive f
  fi

elif [[ "$DIRECTION" == "l" ]]; then 
  if [[ "$CURRENT"  == "$FWINDOW" ]]; then 
    hyprctl dispatch movefocus l

  else hyprctl dispatch changegroupactive b
  fi
fi
