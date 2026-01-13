# vim:foldmethod=marker

# Default settings {{{
if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -x FZF_DEFAULT_OPTS "--color=16 --bind 'alt-f:first,alt-l:last'"
set -g fish_greeting

# function fish_greeting
#     fish_logo
# end

set fish_color_command cad3f5
# }}}

# Custom functions {{{
# Git repo indicator 
function _is_git_repo
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
end

# Save dir on exit
function save_dir_on_exit --on-event fish_exit
    if test $PWD != $HOME
        set -U LAST_DIR $PWD
    end
end
# }}}

# Fish prompt {{{
function fish_prompt
    set -l last_status $status

    echo ""
    set_color brblack & echo -n " ╭─"
    set_color brblack & echo -n "[ "
    set PWD_NEW (string replace --regex "^$HOME" "~" $PWD)

    if _is_git_repo
        set_color red & echo -n "" $PWD_NEW
    else
        set_color blue & echo -n "" $PWD_NEW
    end

    set_color brblack & echo -n " ]"
    set PWD_LEN (string length $PWD_NEW)

    # set STATUS_LEN (math (string length $last_status) +4 )
    if test $last_status -gt 0
        set STATUS_LEN (math (string length $last_status) +6 )
    else
        set STATUS_LEN 0
    end

    set FILL_LEN (math (tput cols) - $PWD_LEN - 21 - $STATUS_LEN)
    if test $FILL_LEN -lt 0
        set FILL_LEN 0
    end

    set_color brblack & printf '%*s' $FILL_LEN '' | sed 's/ /·/g'

    if test $last_status -gt 0
        set_color brblack & echo -n "[ "
        if test $last_status -gt 128
            set_color yellow & echo -n " $last_status"
        else
            set_color red & echo -n " $last_status"
        end
        set_color brblack & echo -n " ]"
    end

    set_color brblack & echo -n "[ "
    set_color brgreen & echo -n " "(date +%H:%M)
    set_color brblack & echo -n " ]"

    echo
    set_color brblack & echo -n " ╰───"
    set_color brblack & echo -n "["

    switch $fish_bind_mode
        case default
            set_color brblue
            echo -n NOR
        case insert
            set_color "#C7A0DC"
            set_color magenta
            echo -n INS
        case replace_one
            set_color yellow
            echo -n REP
        case visual
            set_color brcyan
            # set_color brmagenta
            echo -n VIS
        case '*'
            set_color red
            echo -n REP
    end

    set_color brblack & echo -n "]"
    set_color brmagenta & echo " >> "
end

function fish_mode_prompt
end

# }}}

# Fish keybinds {{{
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert
    bind -M default h fzf_command_history
    bind -M default ? "moar ~/.config/fish/shortcuts.txt"
    # bind -M visual c fish_clipboard_copy
    bind -M visual c 'fish_clipboard_copy; commandline -f end-selection; fish_vi_key_bindings default; commandline -f repaint'
    bind -M insert alt-c 'commandline -r ""; clear; commandline -f repaint'
    bind -M default alt-c 'commandline -r ""; clear; commandline -f repaint'

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

function fzf_command_history
    # set selected (history | fzf --reverse --prompt="Command history: " --no-sort --no-preview)
    set -l selected (history --show-time="%y.%m.%d %H:%M:%S │ " | fzf  --reverse --prompt="Command history: " --no-preview )
    set command_only (string sub -s 21 $selected)
    if test -n "$command_only"
        commandline --replace "$command_only"
    end
end
# }}}

# Aliasses {{{
alias cls='clear'
alias CLS='clear'
alias CLEAR='clear'

alias rm="rm -i"
alias rmd="rm -rf -I -v"

alias tree="tree -C"
alias kys="killall"

alias ls='lsd -F  --group-directories-first'
alias lsl='lsd -F -1 --group-directories-first --blocks date --blocks permission --blocks size --blocks name --date +%Y.%m.%d'
alias sl='lsd -F  --group-directories-first'

alias lsa='lsd -F -a --group-directories-first'
alias lsal='lsd -F -1 -a --group-directories-first --blocks permission --blocks size --blocks name'

alias fzf="fzf --preview 'test -f {}; and bat --color=always {}; or ls --color=always {}'"

alias Pacman='bash ~/.config/scripts/pacman.sh'

alias icat='kitty +kitten icat'

alias drd='dragon-drop -s 256 -x -a'

alias cdp='cd $LAST_DIR'

alias sm='sysmenu --app'

set -x MANPAGER "nvim +Man!"
# }}}

# Exports {{{
export EDITOR="nvim"
export SHELL="/bin/fish"
export PF_INFO="ascii title kernel uptime pkgs shell palette"
# }}}
