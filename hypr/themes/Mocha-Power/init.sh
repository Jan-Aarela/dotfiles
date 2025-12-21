#!/bin/bash

DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
echo $DIR
#swww img $DIR/wallpaper.jpg -t grow --transition-duration 0.5 --transition-fps 90 &

# Check lockscreen
cp $DIR/lock.sh ~/.config/scripts/hypr/lock.sh

# Load waybar
killall waybar
waybar -c $DIR/waybar.jsonc -s $DIR/waybar.css &

# Change Hyprland look
hyprctl keyword general:col.active_border 0xFFb4befe
hyprctl keyword general:col.inactive_border 0xFF45475a
hyprctl keyword group:col.border_active 0xFFb4befe
hyprctl keyword group:col.border_inactive 0xFF45475a

# Change rofi theme
echo @theme "'/usr/share/rofi/themes/custom2.rasi'" >~/.config/rofi/config.rasi

# Change dunst config.
cp $DIR/dunstrc ~/.config/dunst/dunstrc
killall dunst

# Change kitty terminal's theme
cp $DIR/kitty-theme.conf ~/.config/kitty/themes/kitty-theme.conf
kitten themes --reload-in=all kitty-theme

# Change GTK theme
gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-lavender-fix"

# Change QT/Kvantum theme
kvantummanager --set catppuccin-mocha-lavender
