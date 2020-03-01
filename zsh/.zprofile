# Set my config root.
export MY_CONFIG_ROOT="$( cd "$( dirname "${(%):-%N}" )/.." && pwd )"

# Configure path.
typeset -U path
path=(
    bin
    vendor/bin
    $HOME/.composer/vendor/bin
    $HOME/.yarn/bin
    $HOME/.config/yarn/global/node_modules/.bin
    $HOME/bin
    $HOME/.local/bin
    $HOME/Library/Python/3.7/bin
    $MY_CONFIG_ROOT/bin
    /usr/local/go/bin
    $path
)
export PATH

# Various.
export CLICOLOR=1
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="rg --files"
export GOPATH=$HOME/go
export GPG_TTY=$(tty)
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB:en
export LC_ALL=en_GB.UTF-8
export RESTIC_REPOSITORY=sftp:nas:/shares/Data/dietrich-restic
export RIPGREP_CONFIG_PATH=$MY_CONFIG_ROOT/ripgrep.conf
