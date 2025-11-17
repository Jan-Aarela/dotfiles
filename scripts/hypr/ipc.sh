#!/bin/sh

handle() {
  case $1 in
  openwindow*) notify-send lol ;;
  closewindow*) notify-send lol2 ;;
  activewindow*) notify-send lol3 ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
