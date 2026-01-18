if [ ! -f "$MY_CONFIG_ROOT/vendor/fzf-tab/fzf-tab.plugin.zsh" ]; then
    return
fi

autoload -U compinit
compinit

source "$MY_CONFIG_ROOT/vendor/fzf-tab/fzf-tab.plugin.zsh"

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'
