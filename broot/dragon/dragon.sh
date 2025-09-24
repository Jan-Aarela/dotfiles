#!/bin/bash

sleep 0.25

dragon-drop -x -s 256 -A $(cat ~/.config/broot/dragon/dragon_list.txt)

echo "" >~/.config/broot/dragon/dragon_list.txt
