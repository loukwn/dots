# ---
# HISTORY
# ---

setopt share_history
HISTFILE="$ZSH_HOME"/.zsh_history
SAVEHIST=1000  # Save most-recent 1000 lines
HISTSIZE=1000

# ---
# KEY BINDINGS
# 
# list of widgets (actions): https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# get list: zle -la
# ---

# Force Vi mode
bindkey -v

# To add more to this hash see 'man 5 terminfo'
typeset -g -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[Shift-Tab]="${terminfo[kcbt]}"

# Make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.


if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Home
if [[ -n "${key[Home]}" ]]; then
  bindkey -M viins "${key[Home]}" beginning-of-line
  bindkey -M vicmd "${key[Home]}" beginning-of-line
fi

# End
if [[ -n "${key[End]}" ]]; then
  bindkey -M viins "${key[End]}" end-of-line
  bindkey -M vicmd "${key[End]}" end-of-line
fi

# PageUp
if [[ -n "${key[PageUp]}" ]]; then
  bindkey -M viins "${key[PageUp]}" up-line-or-history
  bindkey -M vicmd "${key[PageUp]}" up-line-or-history
fi

# PageDown
if [[ -n "${key[PageDown]}" ]]; then
  bindkey -M viins "${key[PageDown]}" down-line-or-history
  bindkey -M vicmd "${key[PageDown]}" down-line-or-history
fi

# Backspace
if [[ -n "${key[Backspace]}" ]]; then
  bindkey -M viins "${key[Backspace]}" backward-delete-char
  bindkey -M vicmd "${key[Backspace]}" backward-delete-char
fi

# Delete
if [[ -n "${key[Delete]}" ]]; then
  bindkey -M viins "${key[Delete]}" delete-char
  bindkey -M vicmd "${key[Delete]}" delete-char
fi

# Up
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

if [[ -n "${key[Up]}" ]]; then
  bindkey -M viins "${key[Up]}" up-line-or-beginning-search
  bindkey -M vicmd "${key[Up]}" up-line-or-beginning-search
fi

# Down
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

if [[ -n "${key[Down]}" ]]; then
  bindkey -M viins "${key[Down]}" down-line-or-beginning-search
  bindkey -M vicmd "${key[Down]}" down-line-or-beginning-search
fi

# Shift-Tab
if [[ -n "${key[Shift-Tab]}" ]]; then
  bindkey -M viins "${key[Shift-Tab]}" reverse-menu-complete
  bindkey -M vicmd "${key[Shift-Tab]}" reverse-menu-complete
fi

# ---
# COMPLETION
# ---

autoload -Uz compinit && compinit
