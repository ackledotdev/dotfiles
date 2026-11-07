#alias c='src'

alias extip='curl -sS https://ackle.dev/apis/ip'

alias si='sudo -i'

#alias cd='z'

alias d='clear ; ckhyfetch'

alias gayfetch='hyfetch -p rainbow'
alias ff='fastfetch'

alias pf='prideful'

alias egrep='grep -E --color=auto'

alias v='vi'

alias bap='bat -p'

alias fgrep='grep -F --color=auto'

alias pg='ps aux | grep -i'

alias g='git'
#alias cargo='cargo mommy'
#alias gargo='cargo'

alias ciua='cargo install-update -a'
alias sdu='sudo dnf up'
alias sduy='sudo dnf up -y'
alias fpu='flatpak update'
alias fpuy='flatpak update -y'
alias brup='brew upgrade'
alias brcl='brew cleanup'
alias brul='brup && brcl'

alias y='yazi'

alias bc='bc -l'
alias bcl='\bc'

alias wlc='wl-copy'
alias wlp='wl-paste'

alias tree='tree --gitignore'

alias btui='bluetui'
alias wtui='wallflow tui'

alias grep='grep --color=auto'

alias l='ls'
alias l.='ls -d .* --color=auto'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -lA'
alias ls='ls --color=auto'

alias nr='npm run'
alias nrd='nr dev'
alias nrs='npm start'

alias nms='niri msg windows'

alias src='source ~/.bash_profile'

alias lc='fc -ln -1 | sed "s/^[ \t]*//;s/[ \t\n]*$//"'
alias clc='lc | wl-copy'

alias vialias='vi ~/.bash_aliases'
alias viprofile='vi ~/.bash_profile'
alias virc='vi ~/.bashrc'
alias vifn='vi ~/.funcs.bash'

alias vnk='vi ~/.config/niri/config.kdl'
alias nv='niri validate'

export DO_NOT_TRACK=1

export PWR_CFG_DIR=/sys/class/power_supply/

export HOMEBREW_NO_ENV_HINTS=1

ascii_path=~/bin/ascii-logos-uwu/color/ibm-twinkpad-h.txt
ascii_colors=('#FFFFFF' '#55CDFD' '#F6AAB7')
alias tpfetch="neowofetch --ascii $ascii_path --ascii_colors ${ascii_colors[@]}"

alias ']'='ngmcd'

alias gc='git clone'
alias ghc='gh repo clone'

export RIN=662128785
