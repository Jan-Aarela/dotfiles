#/bin/bash

FILE=$1
killall dragon.sh
echo $FILE >> ~/.config/broot/dragon/dragon_list.txt
~/.config/broot/dragon/dragon.sh &
