# Toggle switch for tiled/floating window type.

MODE=$(hyprctl activewindow -j | jq '.floating')

if [[ "$MODE" == "false" ]]; then
  hyprctl dispatch focuswindow floating
else
  hyprctl dispatch focuswindow tiled
fi

