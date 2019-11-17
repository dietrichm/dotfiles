# Load .zprofile when it's not already. This happens on Ubuntu with GDM login.
if [ -z "$MY_CONFIG_ROOT" ]; then
  source "$ZDOTDIR/.zprofile"
fi

# History.
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=1000
SAVEHIST=1000

# Options.
setopt appendhistory beep

# Key bindings.
bindkey -v

# Autocompletion.
# TODO: add completion sources for i.e. Makefiles.
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

# Load subfiles.
for file in "$MY_CONFIG_ROOT"/shell.*.sh; do
  source "$file"
done

# Load FZF.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Force reload hash table.
# This is required on Ubuntu.
hash -f

return 0
