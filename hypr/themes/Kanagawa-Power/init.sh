#!/bin/bash

DIR=$1

#swww img $DIR/wallpaper.jpg -t grow --transition-duration 0.5 --transition-fps 90 &

# Check lockscreen
cp $DIR/lock.sh ~/.config/hypr/scripts/lock.sh

# Load waybar
killall waybar
waybar -c $DIR/waybar.jsonc -s $DIR/waybar.css &

# Change Hyprland look
hyprctl keyword general:col.active_border 0xFFC0A36E
hyprctl keyword general:col.inactive_border 0xFF3B3A37
hyprctl keyword group:col.border_active 0xFFC8C093
hyprctl keyword group:col.border_inactive 0xFF3B3A37

# Change rofi theme
echo @theme "'/usr/share/rofi/themes/custom2.rasi'" >~/.config/rofi/config.rasi

# Change dunst config.
cp $DIR/dunstrc ~/.config/dunst/dunstrc
killall dunst

# Change kitty terminal's theme
cp $DIR/kitty-theme.conf ~/.config/kitty/themes/kitty-theme.conf
kitten themes --reload-in=all kitty-theme

# Change GTK theme
gsettings set org.gnome.desktop.interface gtk-theme "Kanagawa-Dark"

# Change QT/Kvantum theme
kvantummanager --set kanagawa
