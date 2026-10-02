#!/bin/bash
SETTINGS=$(grep "monitor=HDMI-A-1" -i ~/.config/hypr/monitors.conf)
echo "$SETTINGS"

RESOLUTION=$(echo "$SETTINGS" | awk -F "," '{print $2}')
POSITION=$(echo "$SETTINGS" | awk -F "," '{print $3}')
SCALE=$(echo "$SETTINGS" | awk -F "," '{print $4}')
echo "$RESOLUTION" "$POSITION" "$SCALE"

SELECTION=$(echo -e "󰶐\n\n󰍺\n\n" |
  wofi -dmenu -p "HDMI mode" -s ~/.config/wofi/icon.css -c ~/.config/wofi/HDMI)

case "$SELECTION" in
"󰶐")
  aplay ~/.config/sounds/theme_switch.wav &

  # Checks if monitor is disabled.
  if [[ $(hyprctl monitors all -j | jq -r '.[] | select(.name == "HDMI-A-1") | .disabled') == "true" ]]; then
    notify-send "HDMI - Already disabled"
  else
    notify-send "HDMI - Disabled"
    hyprctl keyword monitor HDMI-A-1, disabled
  fi
  ;;
"")
  aplay ~/.config/sounds/theme_switch.wav &

  # Mirrors monitor if monitor is not a mirror.
  if [[ $(hyprctl monitors all -j | jq -r '.[] | select(.name == "HDMI-A-1") | .mirrorOf') == "none" ]]; then
    notify-send "HDMI - mirrored"

    # Move workspaces to eDP-1.
    hyprctl dispatch moveworkspacetomonitor 6 eDP-1
    hyprctl dispatch moveworkspacetomonitor 7 eDP-1
    hyprctl dispatch moveworkspacetomonitor 8 eDP-1
    hyprctl dispatch moveworkspacetomonitor 9 eDP-1
    hyprctl dispatch moveworkspacetomonitor 10 eDP-1

    # Mirror eDP-1 to HDMI-A-1.
    hyprctl keyword monitor HDMI-A-1, "$RESOLUTION","$POSITION","$SCALE",mirror, eDP-1

  else
    # If already mirroed, notify.
    notify-send "HDMI - Already mirrored"
  fi
  ;;
"󰍺")
  aplay ~/.config/sounds/theme_switch.wav &

  # Extends monitor if monitor is disabled or mirrored.
  if [[ $(hyprctl monitors all -j | jq -r '.[] | select(.name == "HDMI-A-1") | .mirrorOf') != "none" ||
  $(hyprctl monitors all -j | jq -r '.[] | select(.name == "HDMI-A-1") | .disabled') == "true" ]]; then
    notify-send "HDMI - Extended"
    hyprctl keyword monitor HDMI-A-1, disabled
    sleep 0.5
    hyprctl keyword monitor HDMI-A-1, "$RESOLUTION","$POSITION","$SCALE"

    # Move workspaces to HDMI-A-1.
    hyprctl dispatch moveworkspacetomonitor 6 HDMI-A-1
    hyprctl dispatch moveworkspacetomonitor 7 HDMI-A-1
    hyprctl dispatch moveworkspacetomonitor 8 HDMI-A-1
    hyprctl dispatch moveworkspacetomonitor 9 HDMI-A-1
    hyprctl dispatch moveworkspacetomonitor 10 HDMI-A-1

    swww restore

  else
    # If already extended, notify.
    notify-send "HDMI - Already extended"
  fi
  ;;
"")
  # Launch nwg-displays and notify.
  aplay ~/.config/sounds/theme_switch.wav &
  nwg-displays

  aplay ~/.config/sounds/theme_switch.wav &
  notify-send "Monitors - Edited with nwg-displays"
  ;;
"")
  # Launch nvim and notify.
  aplay ~/.config/sounds/theme_switch.wav &
  kitty --title='Monitor config' -e nvim ~/.config/hypr/monitors.conf

  # Fixes wallpaper fill.
  swww restore

  aplay ~/.config/sounds/theme_switch.wav &
  notify-send "Monitors - Edited with NeoVim"
  ;;
esac
