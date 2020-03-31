
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
  local c1=$(tput setaf 39)
  local c2=$(tput setaf 33)
  local c3=$(tput setaf 26)
  local reset=$(tput sgr0)
  if [ -n "$SSH_CLIENT" ]; then local sshtext="[$(hostname -s)] "
  fi
  PS1="\[$c3\]${sshtext}\[$c2\]\t \[$c1\]\W\[$c3\]\$(__git_ps1)\[$c1\]\\$\[$reset\] "
}
fancy_prompt

# Title
title() {
  echo -e '\033k'$1'\033\\'
}

# ls
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

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
alias pg="ps aux | grep"
alias wcl="wc -l"
alias trim="awk '{$1=$1};1'"
alias x="exit"

function rgl() {
	rg --color=always --line-number --heading "$@" | less -RS
}
function rgll() {
	rg --color=always --line-number --heading "$@" | less -R
}

function agl() {
	ag --color --numbers --heading "$@" | less -RS
}
function agll() {
	ag --color --numbers --heading "$@" | less -R
}

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
alias g=git
ggb() {
    git grep -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | cat; done
}

# Config Editing
alias bconf="vim -p ~/.bashrc ${BASHFILES[@]}"
alias bload="source ~/.bashrc"
alias gconf="vim -p ~/.gitconfig ${GITFILES[@]}"
alias vconf="vim ~/.vimrc"
alias tconf="vim ~/.tmux.conf"

# Go
export GOPATH=~/gocode
export PATH=$PATH:$GOPATH/bin
alias gobuild="go build . && go tool vet . && go tool vet -shadow . &&"
function gorun { gobuild "./${PWD##*/}"; }

# fzf
if [ -x "$(command -v fd)" ]; then
  export FZF_DEFAULT_COMMAND='fd --type f'
fi

