# vim:foldmethod=marker

function ff
    set -l dir (fd --type d --hidden --exclude .git | fzf -e --prompt="Find directory:" --preview 'lsd --tree --color=always {} | head -200')
    if test -n "$dir"
        cd "$dir"
        commandline -f repaint
    end
end
