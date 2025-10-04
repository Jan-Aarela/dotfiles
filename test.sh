#!/bin/bash

dialog --backtitle "CUSTOM GREEN THEME" \
  --title "\Z1Red Title\Z0" \
  --menu "Select a \Z4Blue\Z0 Option" 15 50 4 \
  1 "Option One" \
  2 "Option Two" \
  3 "Exit" 2>/tmp/choice.txt

clear
