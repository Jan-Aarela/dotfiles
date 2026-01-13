# vim:foldmethod=marker

function fff
    set -l file (fd --type f --hidden --exclude .git | fzf -e --prompt="Find file:" --preview '/usr/bin/bat --color always --theme="Catppuccin Mocha"  {}')
    if test -n "$file"
        set FULL_DIR (realpath (dirname "$file"))
        read -n 1 -p "echo -e '[E] to edit, [ENTER] to cd into \e[34m$FULL_DIR\e[0m: '" -l key
        if [ $key = e ]
            set_color cyan && echo "Editing $file..."
            nvim "$file"
            read -n 1 -p "echo -e '\n[ENTER] to stay at \e[34m$FULL_DIR\e[0m: '" -l key
            if [ $key = "" ]
                set_color cyan && echo -e "cd'd to \e[34m$FULL_DIR\e[0m"
                cd (dirname "$file")
            else
                set_color cyan && echo Returned

            end
        else if [ $key = "" ]
            set_color cyan && echo -e "cd'd to \e[34m$FULL_DIR\e[0m"
            cd (dirname "$file")
        end
    end
end
