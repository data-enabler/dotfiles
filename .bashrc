
# Editor
export EDITOR=vim
set -o vi

# Prompt
source ~/.git-prompt.sh
#Append to history immediately, instead of on exit
export PROMPT_COMMAND='history -a'
export CLICOLOR=1
export PS1='\[\e[1;32m\]\u@\h:\w${text}$\[\e[m\] '
fancy_prompt() {
  local c1=$(tput setaf 4)
  local c2=$(tput setaf 33)
  local c3=$(tput setaf 39)
  local reset=$(tput sgr0)
  if [ -n "$SSH_CLIENT" ]; then local sshtext="[$(hostname -s)] "
  fi
  PS1="${sshtext}\[$c2\]\t \[$c1\]\W\[$c3\]\$(__git_ps1)\\$\[$reset\] "
}
fancy_prompt

# Path
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/lib/python2.7/site-packages:$PATH

# History
HISTCONTROL=ignoreboth
HISTFILESIZE=""
HISTSIZE=""
shopt -s histappend
alias rehist="history -c; history -r"

# Recursive globbing
shopt | grep -q globstar && shopt -s globstar

# Command Line
alias grp="grep -rIn --color=always"
alias egrp="grp -E"
alias fgrp="grp -F"
alias ff="find . -name "

function hggrepblame() {
	for file in `grp -l "$1" $2`; do hg blame -dunl $file | grp "$1"; done
}

function gitgrepblame() {
	for file in `grp -l "$1" $2`; do git blame $file | grp "$1"; done
}

# Utils
alias pysrv="python -m SimpleHTTPServer"
alias ding="printf \\\\a"
alias dun="say done"
function t {
	local TIMEFORMAT=%Rs
	local start=$SECONDS
	($*)
	local end=$SECONDS
	local time=$((end-start))
	osascript -e "display notification \"$*\" with title \"Command finished in ${time}s\" sound name \"Pop\""
	echo ${time}s
	say "Command finished in $time seconds"
}
function mvln {
	original="$1" target="$2"
	if [ -d "$target" ]; then
	  target="$target/${original##*/}"
	fi
	mv -- "$original" "$target"
	ln -s -- "$target" "$original"
}

# Git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
alias gti=git
alias got=git

# Config Editing
alias bconf="vim -p ~/.bashrc ${BASHFILES[@]:-${BASH_SOURCE[0]}}"
alias bload="source ~/.bashrc"
alias vconf="vim ~/.vimrc"
alias gconf="vim -p ~/.gitconfig ${GITFILES[@]}"

# Go
alias gobuild="go build . && go tool vet . && go tool vet -shadow . &&"
function gorun { gobuild "./${PWD##*/}"; }

