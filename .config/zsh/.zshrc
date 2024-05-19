# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above init_p10k; everything else may go below.

# This just sets an empty title for terminals like Kitty and Foot.
print -Pn "\e] \e\\"

source "$ZSH_HOME"/init_p10k.zsh
source "$ZSH_HOME"/zsh_config.zsh
source "$ZSH_HOME"/functions.zsh
source "$ZSH_HOME"/aliases.zsh
source "$ZSH_HOME"/program_inits.zsh
source "$ZSH_HOME"/plugins.zsh
