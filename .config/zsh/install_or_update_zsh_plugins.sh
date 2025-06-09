declare -A plugins

plugins[zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
plugins[zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"

mkdir -p "$ZDOTDIR/plugins"
cd "$ZDOTDIR/plugins"

for plugin in "${!plugins[@]}"
do
    plugin_repo="${plugins[$plugin]}"
    if [ -d "$plugin" ]; then
        echo "Attempting to update $plugin..."
        cd "$plugin"
        git pull
    else
        echo "$plugin does not exist. Installing..."
        git clone "$plugin_repo"
fi
done
