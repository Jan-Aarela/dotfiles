# Checks currently focused window's type,
# then focuses to another window type.

MODE=$(hyprctl activewindow -j | jq '.floating')

if [[ "$MODE" == "false" ]]; then
  hyprctl dispatch focuswindow floating
else
  hyprctl dispatch focuswindow tiled
fi

