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

source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/prompt.zsh"

return 0
