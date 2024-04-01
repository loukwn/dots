# Install Powerlevel10k if not there.
if [ ! -d "$ZSH_HOME/powerlevel10k" ]; then
    echo "Looks like Powerlevel10k is not installed. Installing."
    mkdir -p "$ZSH_HOME/powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_HOME/powerlevel10k"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$ZSH_HOME"/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
