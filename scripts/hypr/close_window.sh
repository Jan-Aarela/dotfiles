# STATUS=$(cat ~/.config/hypr/scripts/close_variable)
#
# if [[ "$STATUS" == 0 ]]; then
#   echo 1 > ~/.config/hypr/scripts/close_variable
#   sleep 0.25
#   echo "$STATUS"
#   echo 0 > ~/.config/hypr/scripts/close_variable
# else
#   echo 0 > ~/.config/hypr/scripts/close_variable
#   hyprctl dispatch killactive
# fi

ADDRESS1=$(cat ~/.config/scripts/hypr/close_variable)
ADDRESS2=$(hyprctl activewindow -j | jq '.address')

if [[ "$ADDRESS2" == "$ADDRESS1" ]]; then
  echo 0 >~/.config/scripts/hypr/close_variable
  hyprctl dispatch killactive
else
  echo "$ADDRESS2" >~/.config/scripts/hypr/close_variable
  sleep 0.25
  echo 0 >~/.config/scripts/hypr/close_variable
fi
