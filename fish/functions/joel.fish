# vim:foldmethod=marker

function joel
    if test "$argv" = f
        icat --align left ~/.config/fish/joelxl.gif
    else
        icat --place 40x40@-60x20 ~/.config/fish/joel.gif &
        echo -e "\n\n                                      \e[3mI am just a fish\n"
    end
end
