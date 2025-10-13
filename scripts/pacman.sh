#!/bin/bash

aplay ~/.config/sounds/Pacman.wav >/dev/null 2>/dev/null &

# ART=" \| \'_ \\ / _\` \|/ __\| \'_ \` _ \\ / _\` | '_ \\"

ART=$'"" \
"\e[31m               \e[34m║      ║  \e[0mSCORE:  3333360 \n" \
"\e[34m══════════════════╝      ╚══════════════════════════════════════════════╗" \
"\n      \e[31m,--.    \e[33m,--.          \e[36m,--.   \e[32m,--.                           \e[35m,--.   \e[34m║" \
"\n     \e[31m|oo  |    \e[33m\  \`.       \e[36m| oo | \e[32m|  oo|                         \e[35m|oo  |  \e[34m║" \
"\n\e[33m o  o\e[31m|~~  |   \e[33m /   ;       \e[36m| ~~ | \e[32m|  ~~|\e[33mo  o  o  o  o  o  o  o  o\e[35m|~~  |  \e[34m║" \
"\n     \e[31m|/\/\|   \e[33m\'._,\'        \e[36m|/\/\| \e[32m|/\/\|                         \e[35m|/\/\|  \e[34m║" \
"\n\e[34m ══════════════════╗      ╔══════════════════════════════════════════════╝" \
"\n                   ║      ║  \e[0mPacman -Syu \n" \
'
END="\n \e[33m══════════════════════════\e[30;43m Pacman fukin died! \e[33;49m═══════════════════════════\n"

kitty --title Pacman -e bash -c "echo -e $ART && sudo pacman -Syu && (echo -e ' $END' & sleep 3.5)" &

sleep 1
WINDOW=$(hyprctl clients -j | jq -r '.[] | select(.title | contains("Pacman")) | .pid')

while true; do
  if [[ -z "$WINDOW" ]]; then
    killall aplay
    aplay ~/.config/sounds/pacman_dead.wav
    exit 0
  fi

  WINDOW=$(hyprctl clients -j | jq -r '.[] | select(.title | contains("Pacman")) | .pid')

  PACMAN=$(pgrep "pacman")
  if [[ -n "$PACMAN" && -n "$WINDOW" ]]; then
    killall aplay
    break
  fi

  sleep 0.2
done

aplay ~/.config/sounds/Pacmannin.wav &

while true; do
  if [[ -z "$PACMAN" ]]; then
    killall aplay
    aplay ~/.config/sounds/pacman_dead.wav
    exit 0
  fi
  PACMAN=$(pgrep "pacman")
  sleep 0.2
done
