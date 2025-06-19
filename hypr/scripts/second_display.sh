SETTINGS=$(grep "monitor=HDMI-A-1" -i ~/.config/hypr/monitors.conf)
echo "$SETTINGS"

RESOLUTION=$(echo "$SETTINGS" | awk -F "," '{print $2}')
POSITION=$(echo "$SETTINGS" | awk -F "," '{print $3}')
SCALE=$(echo "$SETTINGS" | awk -F "," '{print $4}')
echo "$RESOLUTION" "$POSITION" "$SCALE"


SELECTION=$(echo -e "󰶐  Disable\n  Mirror\n󰍺  Extend\n  nwg-displays\n  monitors.conf" \
          | wofi -dmenu -p "HDMI mode" -W 320 -H 290 -w 1 -s ~/.config/wofi/power.css -O default -k /dev/null)

case "$SELECTION" in
  "󰶐  Disable")
    aplay ~/.config/sounds/theme_switch.wav &
    
    # Checks if monitor is disabled.
    if [[ $(hyprctl monitors all -j | jq -r '.[] | select(.name == "HDMI-A-1") | .disabled') == "true" ]]; then
      notify-send "HDMI - Already disabled"
    else
      notify-send "HDMI - Disabled"
      hyprctl keyword monitor HDMI-A-1, disabled
    fi
    ;;
  "  Mirror")
    aplay ~/.config/sounds/theme_switch.wav &

    # Mirrors monitor if monitor is not a mirror.
    if [[ $(hyprctl monitors all -j | jq -r '.[] | select(.name == "HDMI-A-1") | .mirrorOf') == "none" ]]; then
      notify-send "HDMI - mirrored"

      # Move workspaces to eDP-1.
      hyprctl dispatch moveworkspacetomonitor	6 eDP-1
      hyprctl dispatch moveworkspacetomonitor	7 eDP-1
      hyprctl dispatch moveworkspacetomonitor	8 eDP-1
      hyprctl dispatch moveworkspacetomonitor	9 eDP-1
      hyprctl dispatch moveworkspacetomonitor	10 eDP-1
     
      # Mirror eDP-1 to HDMI-A-1.
      hyprctl keyword monitor HDMI-A-1, "$RESOLUTION","$POSITION","$SCALE",mirror, eDP-1

    else
      # If already mirroed, notify.
      notify-send "HDMI - Already mirrored"
    fi
    ;;
  "󰍺  Extend")
    aplay ~/.config/sounds/theme_switch.wav &
    
    # Extends monitor if monitor is disabled or mirrored.
    if [[ $(hyprctl monitors all -j | jq -r '.[] | select(.name == "HDMI-A-1") | .mirrorOf') != "none" \
      || $(hyprctl monitors all -j | jq -r '.[] | select(.name == "HDMI-A-1") | .disabled') == "true" ]]; then
      notify-send "HDMI - Extended"
      hyprctl keyword monitor HDMI-A-1, disabled
      sleep 0.5
      hyprctl keyword monitor HDMI-A-1, "$RESOLUTION","$POSITION","$SCALE"
 
      # Move workspaces to HDMI-A-1.
      hyprctl dispatch moveworkspacetomonitor	6 HDMI-A-1
      hyprctl dispatch moveworkspacetomonitor	7 HDMI-A-1
      hyprctl dispatch moveworkspacetomonitor	8 HDMI-A-1
      hyprctl dispatch moveworkspacetomonitor	9 HDMI-A-1
      hyprctl dispatch moveworkspacetomonitor	10 HDMI-A-1

    else
      # If already extended, notify.
      notify-send "HDMI - Already extended"
    fi
    ;;
  "  nwg-displays")
    # Launch nwg-displays and notify. 
    aplay ~/.config/sounds/theme_switch.wav &
    nwg-displays

    aplay ~/.config/sounds/theme_switch.wav &
    notify-send "Monitors - Edited with nwg-displays"
    ;;
  "  monitors.conf")
    # Launch nvim and notify.
    aplay ~/.config/sounds/theme_switch.wav &
    kitty --title='Monitor config' -e nvim ~/.config/hypr/monitors.conf

    # Fixes wallpaper fill.
    swww restore

    aplay ~/.config/sounds/theme_switch.wav &
    notify-send "Monitors - Edited with NeoVim"
    ;;
esac
