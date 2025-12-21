# vim:foldmethod=marker

# Default settings {{{
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting
set fish_color_command cad3f5

# }}}

# Custom functions {{{
# Git repo indicator 
function _is_git_repo
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
end
# }}}

# Fish prompt {{{
function fish_prompt
    echo ""
    set_color brblack & echo -n " ╭─"
    set_color brblack & echo -n "// "
    set_color brgreen & echo -n " "(date +%H:%M)
    set_color brblack & echo -n " // "
    set PWD_NEW (string replace --regex "^$HOME" "~" $PWD)

    if _is_git_repo
        set_color red & echo -n "" $PWD_NEW
    else
        set_color blue & echo -n "" $PWD_NEW
    end

    set_color brblack & echo -n " //"
    set PWD_LEN (string length $PWD_NEW)

    set FILL_LEN (math (tput cols) - $PWD_LEN - 23)
    if test $FILL_LEN -lt 0
        set FILL_LEN 0
    end

    set_color brblack & printf '%*s' $FILL_LEN '' | sed 's/ /·/g'
    echo
    set_color brblack & echo -n " ╰───"
    set_color brblack & echo -n "["

    switch $fish_bind_mode
        case default
            set_color brblue
            echo -n NOR
        case insert
            set_color "#C7A0DC"
            echo -n INS
        case replace_one
            set_color yellow
            echo -n REP
        case visual
            set_color brcyan
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
    set selected (history | fzf --reverse --prompt="Command history: " --no-sort)
    if test -n "$selected"
        commandline --replace "$selected"
    end
end
# }}}

# Exports {{{
export EDITOR="nvim"
export SHELL="/bin/fish"
export PF_INFO="ascii title kernel uptime pkgs shell palette"

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

function nsx
    if test (count $argv) -gt 1
        nsxiv -to -g 1500x1000 $argv[1..-1]
    else if test (count $argv) -eq 1
        nsxiv -g 1500x1000 $argv[1]
    else
        nsxiv -to -g 1500x1000 *
    end
end

set -x MANPAGER "nvim +Man!"
# }}}

# git repo ascii / onefetch {{{
function cd -w='cd'
    builtin cd $argv || return
    check_directory_for_new_repository
end

function check_directory_for_new_repository
    set current_repository (git rev-parse --show-toplevel 2> /dev/null)
    if [ "$current_repository" ] && [ "$current_repository" != "$last_repository" ]
        # onefetch --nerd-fonts
        bash ~/.config/scripts/onefetch.sh
    end
    set -gx last_repository $current_repository
end

# funcsave cd
# funcsave check_directory_for_new_repository

# }}}

# clear
