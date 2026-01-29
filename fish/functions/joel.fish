# vim:foldmethod=marker

function joel
    if test "$argv" = f
        icat --align left ~/.config/fish/joelxl.gif
    else
        icat --place 40x40@-60x20 ~/.config/fish/joel.gif
        echo -e "\n\n                                      \e[3mI am just a fish\n"
        # echo -e "\n\n                                     \e[3m\e[90m[ \e[36mI am just a fish \e[90m]\e[0m\n"

    end
end
