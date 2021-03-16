# History.
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=1000
SAVEHIST=1000

# Options.
setopt appendhistory
setopt beep
setopt globdots

# Disable right prompt indent.
ZLE_RPROMPT_INDENT=0

# Key bindings.
bindkey -v

# Load FZF.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Autocompletion.
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit
source "$MY_CONFIG_ROOT/vendor/fzf-tab/fzf-tab.plugin.zsh"

# Load subfiles.
for file in "$ZDOTDIR"/*.zsh; do
    source "$file"
done

return 0
