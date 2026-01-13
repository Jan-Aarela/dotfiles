# vim:foldmethod=marker

function pks
    expac --timefmt='%Y-%m-%d %H:%M:%S' "\e[32m%l\e[0m  \e[35m%-12w\e[0m  \e[1m%-32n\e[0m  \e[33m%v\e[0m" | sort -n | moor +999999
end
