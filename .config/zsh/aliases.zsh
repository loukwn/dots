alias sourcerc='source $ZDOTDIR/.zshrc'
alias editzshconfig='nvim $XDG_CONFIG_HOME/zsh/'
alias updatep10k='git -C $ZDOTDIR/powerlevel10k pull'

alias ls='ls --color=auto'
alias rm='rm -i'
alias tt='gio trash'
alias st='thunar trash:///'

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

alias icat="kitten icat"

# kitty ssh fix
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh" 
