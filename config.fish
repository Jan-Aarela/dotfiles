if status is-interactive
    # Commands to run in interactive sessions can go here
end


set -g fish_greeting

function fish_prompt
	set_color cyan   & echo -n " ╭─"
	set_color red   & echo -n "["
	set_color white & echo -n (date +%H:%M)
	set_color red   & echo -n "]"
	set_color cyan  & echo -n "──"
	set_color red   & echo -n "["
	# set_color white & echo -n (whoami)
	set_color blue  & echo -n "@"
	set_color white & echo -n "~"(pwd)
	set_color red   & echo    "]"
	set_color cyan  & echo -n " ╰──"
	set_color red   & echo    "𜰕 "

end

export EDITOR="nvim"
export SHELL="fish"

export PF_INFO="ascii title kernel uptime pkgs shell palette"

export PF_ASCII="arch"

# Aliasses
alias cls='clear'
alias ls='lsd -F -1'
alias lsa='lsd -F -1 -a'
alias swa='devour'

pfetch

