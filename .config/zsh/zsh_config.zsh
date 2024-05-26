HISTFILE="$ZSH_HOME"/.zsh_history
SAVEHIST=1000  # Save most-recent 1000 lines
HISTSIZE=1000

# Search history using what already typed (Up and down arrows)
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Add completion system. (Git tab-completion etc.)
autoload -Uz compinit && compinit
