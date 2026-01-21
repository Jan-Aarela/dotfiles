function dotline
    set DOTLINE_LEN ( math (tput cols) )

    echo -e "\n"
    set_color brblack & printf '%*s' $DOTLINE_LEN '' | sed 's/ /·/g'
    echo -e "\n"

end
