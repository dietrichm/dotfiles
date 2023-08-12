# History.
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=30000
SAVEHIST=30000

# Options.
setopt appendhistory
setopt beep
unsetopt list_beep
setopt globdots

# Disable right prompt indent.
ZLE_RPROMPT_INDENT=0

# Key bindings.
bindkey -v

# Load fzf.
# https://bugzilla.redhat.com/show_bug.cgi?id=1513913
[ -f /usr/share/zsh/site-functions/fzf ] && source /usr/share/zsh/site-functions/fzf
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh

# Load direnv.
[ -f ~/.config/direnv/direnv.toml ] && eval "$(direnv hook zsh)"

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
