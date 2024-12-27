#!/hint/bash

# START TIMER to measure bashrc load time performance
timer_start=$(date +%s%N)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

unalias -a

alias config='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# make commands output colorful by default
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias diff='diff --color=auto'
if command -v bat &> /dev/null; then
	alias cat='bat -pp'
fi

PS1="\[\e[0m\]\w \[\e[31m\]\${?#0}\[\e[0m\]\\$ "

HISTSIZE=-1
HISTFILESIZE=-1
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

alias la='ls -lAh'
alias lat='ls -lAhtr'

export EDITOR='/usr/bin/nano'

# used by e.g. man to open man pages in the browser by using the -H option
export BROWSER=firefox

fm() {
	if [ -n "$1" ]; then
		if [ -d "$1" ]; then
			xdg-open "$1" >/dev/null 2>&1
		else
			xdg-open "$(dirname "$1")" >/dev/null 2>&1
		fi
	else
		xdg-open "$(pwd)" >/dev/null 2>&1
	fi
}

#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'

. ".bashrc.local"

# STOP TIMER to measure bashrc load time performance
# - DO NOT INSERT ANYTHING BELOW
timer_end=$(date +%s%N)
time_elapsed=$(((timer_end - timer_start) / 1000000))

if [ "$time_elapsed" -gt 100 ]; then
	echo "${HOME}/.bashrc loaded in ${time_elapsed}ms."
fi

unset timer_start timer_end time_elapsed
