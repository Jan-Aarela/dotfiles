# vim:foldmethod=marker

# Default settings{{{
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

# }}}

# Fish prompt{{{
function fish_prompt
	echo ""
  set_color brblack  & echo -n " ╭─"
	set_color brblack   & echo -n "// "
	set_color brgreen & echo -n  " "(date +%H:%M)
	set_color brblack   & echo -n " // "
  set PWD_NEW (string replace --regex "^$HOME" "~" $PWD)
	set_color blue & echo -n "" $PWD_NEW
	set_color brblack  & echo -n " //"
  set PWD_LEN (string length $PWD_NEW)

  set FILL_LEN (math (tput cols) - $PWD_LEN - 23)
  if test $FILL_LEN -lt 0
    set FILL_LEN 0
  end

  set_color brblack & printf '%*s' $FILL_LEN '' | sed 's/ /·/g'; echo
	set_color brblack  & echo -n " ╰───"
	set_color brblack  & echo -n "["

  switch $fish_bind_mode
    case default
      set_color brblue
      echo -n 'Normal'
    case insert
      set_color "#C7A0DC"
      echo -n 'Insert'
    case replace_one
      set_color yellow
      echo -n 'Replace'
    case visual
      set_color brcyan
      echo -n 'Visual'
    case '*'
      set_color red
      echo -n '?'
  end

	set_color brblack  & echo -n "]"
	set_color brmagenta   & echo    " >> "
end

# }}}

# Fish prompt old{{{
# function fish_prompt
# 	set_color white  & echo -n " ╭─"
# 	set_color cyan   & echo -n "[ "
# 	set_color white & echo -n (date +%H:%M)
# 	set_color cyan   & echo -n ""
# 	set_color cyan  & echo -n " ] "
# 	set_color cyan   & echo -n ""
# 	# set_color white & echo -n (whoami)
# 	set_color white & echo "~"(pwd)
# 	set_color white  & echo -n " ╰──"
# 	set_color cyan   & echo    "I> "
# end
# }}}

# Fish keybinds{{{
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert
    bind -M default h fzf_command_history
    bind -M default ? "moar ~/.config/fish/shortcuts.txt"

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

# Exports{{{
export EDITOR="nvim"
export SHELL="/bin/fish"
export PF_INFO="ascii title kernel uptime pkgs shell palette"

# }}}

# Aliasses{{{
alias cls='clear'
alias CLS='clear'
alias CLEAR='clear'
alias tree="tree -C"
alias kys="killall"

alias ls='lsd -F  --group-directories-first'
alias lsl='lsd -F -1 --group-directories-first --blocks date --blocks permission --blocks size --blocks name --date +%Y.%m.%d'

alias lsa='lsd -F -a --group-directories-first'
alias lsal='lsd -F -1 -a --group-directories-first --blocks permission --blocks size --blocks name'

alias fzf="fzf --preview 'test -f {}; and bat --color=always {}; or ls --color=always {}'"

alias Pacman='aplay /home/jan-aarela/.config/sounds/pacman.wav> /dev/null 2>/dev/null & sudo pacman -Syu'

# }}}
