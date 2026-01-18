[ -z "$MY_CONFIG_ROOT" ] && source "$ZDOTDIR/.zprofile"

# History.
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=30000
SAVEHIST=30000

# Options.
setopt appendhistory
setopt beep
unsetopt list_beep
setopt globdots

# Key bindings.
bindkey -v

# Load fzf.
# https://bugzilla.redhat.com/show_bug.cgi?id=1513913
[ -f /usr/share/zsh/site-functions/fzf ] && source /usr/share/zsh/site-functions/fzf
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh

# Load direnv.
[ -f ~/.config/direnv/direnv.toml ] && eval "$(direnv hook zsh)"

# Autocompletion.
autoload -U compinit
compinit
[ -f "$MY_CONFIG_ROOT/vendor/fzf-tab/fzf-tab.plugin.zsh" ] && source "$MY_CONFIG_ROOT/vendor/fzf-tab/fzf-tab.plugin.zsh"
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'

# Load subfiles.
for file in "$ZDOTDIR"/*.zsh; do
    source "$file"
done

return 0
