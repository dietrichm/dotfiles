export MY_CONFIG_ROOT="$( cd "$( dirname "${(%):-%N}" )/.." && pwd )"
export GOPATH=$HOME/go

typeset -U path
path=(
    bin
    vendor/bin
    node_modules/.bin
    $HOME/.composer/vendor/bin
    $HOME/.yarn/bin
    $HOME/.config/yarn/global/node_modules/.bin
    $HOME/bin
    $HOME/.local/bin
    $HOME/.luarocks/bin
    $GOPATH/bin
    $MY_CONFIG_ROOT/bin
    /usr/local/go/bin
    $path
    $MY_CONFIG_ROOT/bin/fallback
)
export PATH

export CLICOLOR=1
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--no-mouse"
export GPG_TTY=$(tty)
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB:en
export LC_ALL=en_GB.UTF-8
export NVIM_LSP=1
export RESTIC_REPOSITORY=sftp:nas:/shares/Data/dietrich-restic
export RIPGREP_CONFIG_PATH=$HOME/.ripgrep.conf
