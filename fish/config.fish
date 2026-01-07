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

# Save dir on exit
function save_dir_on_exit --on-event fish_exit
    set -U LAST_DIR $PWD
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
    bind -M insert alt-c 'commandline -r ""; clear; commandline -f repaint;'
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

# alias cdp='cd $LAST_DIR'

function nsx
    if test (count $argv) -gt 1
        nsxiv -to -g 1500x1000 $argv[1..-1]
    else if test (count $argv) -eq 1
        nsxiv -g 1500x1000 $argv[1]
    else
        nsxiv -to -g 1500x1000 *
    end
end

function bat
    if test (count $argv) -eq 0
        echo "No args."
    else
        /bin/bat --theme="Catppuccin Mocha" $argv[1]
    end
end

set -x MANPAGER "nvim +Man!"
# }}}

# CD {{{
function cd --description 'Change directory'
    set -l MAX_DIR_HIST 25

    if set -q argv[2]; and begin
            set -q argv[3]
            or not test "$argv[1]" = --
        end
        printf "%s\n" (_ "Too many args for cd command") >&2
        return 1
    end

    # Skip history in subshells.
    if status --is-command-substitution
        builtin cd $argv
        return $status
    end

    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = -
        if test "$__fish_cd_direction" = next
            nextd
        else
            prevd
        end
        return $status
    end

    builtin cd $argv
    set -l cd_status $status

    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev
        or set -l dirprev
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]

        # If dirprev, dirnext, __fish_cd_direction
        # are set as universal variables, honor their scope.

        set -U -q dirprev
        and set -U -a dirprev $previous
        or set -g -a dirprev $previous

        set -U -q dirnext
        and set -U -e dirnext
        or set -e dirnext

        set -U -q __fish_cd_direction
        and set -U __fish_cd_direction prev
        or set -g __fish_cd_direction prev
    end

    check_directory_for_new_repository
    return $cd_status
end

# }}}

# Onefetch  {{{
function check_directory_for_new_repository
    set current_repository (git rev-parse --show-toplevel 2> /dev/null)
    if [ "$current_repository" ] && [ "$current_repository" != "$last_repository" ]
        # onefetch --nerd-fonts
        bash ~/.config/scripts/onefetch.sh
    end
    set -gx last_repository $current_repository
end
# }}}

# clear
