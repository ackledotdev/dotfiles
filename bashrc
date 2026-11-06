#!/usr/bin/env bash
#
# Best bashrc in history
#
# Author: Dave Eddy <dave@daveeddy.com>
# Date: Sometime in 2011
# License: MIT

# If not running interactively, don't do anything
[[ -n $PS1 ]] || return

if [ -f ~/.bash_funcs ]; then
    . ~/.bash_funcs
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load bics, plugins found in bics-plugins
. ~/.bics/bics || echo '> failed to load bics' >&2

# -- Environment
export SYSTEMD_PAGER=
export EDITOR='vim'
export GREP_COLOR='1;36'
# export LSCOLORS='ExGxbEaECxxEhEhBaDaCaD'
export MANPAGER='less'
export PAGER='less'
export VISUAL='vim'

# Set environment and configure bash
#HISTCONTROL='ignoredups'
HISTSIZE=10000
HISTFILESIZE=100000
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

. ~/.bash_termcap || echo '> failed to load termcap' >&2

# PATH
. "$HOME/.cargo/env"

# Golang
#if [[ -d ~/go/bin ]]; then
#    PATH="$HOME/go/bin:$PATH"
#fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Shell Options
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s dotglob
# Bash Version >= 4
shopt -s autocd    2>/dev/null || true
shopt -s direxpand 2>/dev/null || true
shopt -s dirspell  2>/dev/null || true

# because `master` is sometimes `main` (or others), these must be functions.
gmb() { # git main branch
	local main
	main=$(git symbolic-ref --short refs/remotes/origin/HEAD)
	main=${main#origin/}
	[[ -n $main ]] || return 1
	echo "$main"
}

# show the diff from inside a branch to the main branch
gbd() { # git branch diff
	local mb
	mb=$(gmb) || return 1
	git diff "$mb..HEAD"
}

# checkout the main branch and update it
gcm() { # git checkout $main
	local mb
	mb=$(gmb) || return 1
	git checkout "$mb" && git pull
}

# merge the main branch into our branch
gmm() { # git merge $main
	local mb
	mb=$(gmb) || return 1
	git merge "$mb"
}

# -- Prompt logic

# change the prompt colors to a theme
# there are 116 possible themes - themes are 0-115
# prompt-set-theme() {
# 	local theme=${1:-0}
# 	local j=0
# 	for ((i = theme; i <= 255; i += 30)); do
# 		PROMPT_COLORS[j]=$'\e[38;5;'${i}m
# 		((j++))
# 	done
# }

# prompt-init() {
# 	local red=$'\e[31m'
# 	local reset=$'\e[0m'
# 	local bold=$'\e[1m'

# 	# custom prompt for YSAP videos
# 	if [[ $ITERM_PROFILE == 'YSAP'* ]]; then
# 		# username
# 		PS1='\[${PROMPT_COLORS[0]}\]\u\['"$reset"'\]'

# 		# @
# 		PS1+='\[${PROMPT_COLORS[1]}\]\['"$bold"'\]@\['"$reset"'\]'

# 		# hostname
# 		PS1+='\[${PROMPT_COLORS[3]}\]ysap '

# 		# cwd (this makes it too horizontal)
# 		# PS1+='\[${PROMPT_COLORS[5]}\]\w '

# 		# prompt character
# 		PS1+='\[${PROMPT_COLORS[2]}\]\$\['"$reset"'\] '

# 		PROMPT_DIRTRIM=1

# 		return
# 	fi

# 	# get host info only once
# 	local zonename=$(zonename 2>/dev/null)
# 	local uname=$(uname | tr '[:upper:]' '[:lower:]')

# 	# Construct the prompt:
# 	# [(exit code)] <user> - <hostname> <uname> <cwd> [git branch] <$|#>

# 	# exit code of last process
# 	PS1='$(c=$?;((c!=0))&&echo "\['"$red"'\]($c) \['"$reset"'\]")'

# 	# username (red for root)
# 	PS1+='\[${PROMPT_COLORS[0]}\]\['"$bold"'\]'
# 	PS1+='$(((UID==0))&&echo "\['"$red"'\]")\u\['"$reset"'\] - '

# 	# zonename (global zone warning)
# 	if [[ $zonename == 'global' ]]; then
# 		PS1+='\['"$red"'\]\['"$bold"'\]GZ:\['"$reset"'\]'
# 	fi

# 	# hostname
# 	PS1+='\[${PROMPT_COLORS[3]}\]\h '

# 	# uname
# 	PS1+='\[${PROMPT_COLORS[2]}\]'"$uname"' '

# 	# cwd
# 	PS1+='\[${PROMPT_COLORS[5]}\]\w '

# 	# optional git branch
# 	#
# 	# THIS IS UNFORTUNATE LOL. i hate how long this line is, but i
# 	# purposefully try to keep this as tight as possible because even just
# 	# spacing it all out has a noticeable effect on speed.
# 	PS1+='$(b=$(git rev-parse --abbrev-ref HEAD 2>/dev/null);[[ -n $b ]]'
# 	PS1+='&&echo -n "\[${PROMPT_COLORS[2]}\](\[${PROMPT_COLORS[3]}\]'
# 	PS1+='git:$b\[${PROMPT_COLORS[2]}\]) ")'

# 	# prompt character
# 	PS1+='\[${PROMPT_COLORS[0]}\]\$\['"$reset"'\] '

# 	# initalize a basic theme just to ensure some colors are set
# 	prompt-set-theme 0
# }

# prompt-update() {
# 	local user=$USER
# 	local host=${HOSTNAME%%.*}

# 	# get the PWD from the prompt as that handles escaping dangerous chars
# 	# for us
# 	local s='\w'
# 	local pwd=${s@P}

# 	# update title bar
# 	local ssh=
# 	[[ -n $SSH_CLIENT ]] && ssh='[ssh] '
# 	printf '\e]0;%s%s@%s:%s\a' "$ssh" "$user" "$host" "$pwd"
# }

# PROMPT_COLORS=()
# PROMPT_COMMAND=prompt-update
# PROMPT_DIRTRIM=6

# prompt-init
# prompt-set-theme 24

# -- Useful functions

# upload a file to my personal CDN
# cdn() {
# 	local file=$1
# 	local bname=${file##*/}

# 	[[ -n $file && -n $bname ]] || return 1

# 	local url
# 	printf -v url '%(%Y/%m/%d)T/%s' -1 "$bname"
# 	local remote_file="./cdn/$url"

# 	# use rsync over scp because we can skip overwriting files
# 	rsync -avh --mkpath --progress --ignore-existing -- \
# 	    "$file" "cdn:$remote_file" || return 1

# 	echo "https://cdn.ysap.sh/$url"
# }

# Print all 256 colors
colors() {
	local i
	for i in {0..255}; do
		printf '\e[38;5;%dmcolor %d\n' "$i" "$i"
	done
	printf '\e[0m'
}

# Convert epoch to human readable (print current date if no args)
epoch() {
	local num=${1:--1}
	printf '%(%B %d, %Y %-I:%M:%S %p %Z)T\n' "$num"
}

# Open the current path or file in GitHub
gho() {
	local file=$1
	local remote=${2:-origin}

	# get the git root dir, branch, and remote URL
	local gr=$(git rev-parse --show-toplevel)
	local branch=$(git rev-parse --abbrev-ref HEAD)
	local url=$(git config --get "remote.$remote.url")

	[[ -n $gr && -n $branch && -n $remote ]] || return 1

	# construct the path
	local path=${PWD/#$gr/}
	[[ -n $file ]] && path+=/$file

	# extract the username and repo name
	local a
	IFS=:/ read -r -a a <<< "$url"
	local len=${#a[@]}
	local user=${a[len-2]}
	local repo=${a[len-1]%.git}

	url="https://github.com/$user/$repo/tree/$branch$path"
	echo "$url"
	open "$url"
}

# print lines over X columns (defaults to 80)
over() {
	local c=${1:-80}
	expand | awk -v "c=$c" 'length($0) > c {
		printf("%4d %s\n", NR, $0);
	}'
}

# print a rainbow if truecolor is available to the terminal
truecolor-rainbow() {
	local i r g b
	for ((i = 0; i < 77; i++)); do
		r=$((255 - (i * 255 / 76)))
		g=$((i * 510 / 76))
		b=$((i * 255 / 76))
		((g > 255)) && g=$((510 - g))
		printf '\033[48;2;%d;%d;%dm ' "$r" "$g" "$b"
	done
	printf '\e[0m\n'
}

# Follow redirects to untiny a tiny url
untiny() {
	local url=$1

	while [[ -n $url ]]; do
		echo "-> $url"
		url=$(curl -sSI -o /dev/null -w '%header{location}' "$url") \
		    || return 1
	done

	return 0
}

# Load external files
. ~/.bash_aliases 2>/dev/null
. ~/.bashrc.local 2>/dev/null

# load tools

eval "$(pay-respects bash --alias fuck)"
eval "$(ngm shell)"
eval "$(starship init bash)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# if type brew &>/dev/null; then
# 	HOMEBREW_PREFIX="$(brew --prefix)"
# 	source "${HOMEBREW_PREFIX}/etc/bash_completion"
# fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# This ^ loads nvm bash_completion

eval "$(zoxide init bash)"

# return success no matter what
true
