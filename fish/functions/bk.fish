# vim:foldmethod=marker

function bk
    set budir "$HOME/backups/"
    if not test -d $budir
        mkdir $budir
        echo "No 'backups' dir, make one."
    end
    set -l rawname (basename $argv[1] | cut -d. -f1)
    set -l name "$rawname-"(date +%Y-%m-%d-%H-%M)".bak"

    cp $argv[1] $budir$name
    echo -e "\n$argv[1] backed up to $budir$name.\n"

end
