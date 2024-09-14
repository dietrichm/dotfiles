export MY_CONFIG_ROOT="$( cd "$( dirname "${(%):-%N}" )/.." && pwd )"
export GOPATH=$HOME/go

typeset -U path
path=(
    bin
    vendor/bin
    node_modules/.bin
    $HOME/.config/composer/vendor/bin
    $HOME/.config/yarn/global/node_modules/.bin
    $HOME/bin
    $HOME/.local/bin
    $HOME/.luarocks/bin
    $GOPATH/bin
    $path
)
export PATH

export CLICOLOR=1
export DELTA_PAGER="less -RFX"
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="rg --files"
export GPG_TTY=$(tty)
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB:en
export LC_ALL=en_GB.UTF-8
export MANPAGER="nvim +Man!"
export MANWIDTH=999
export RIPGREP_CONFIG_PATH=$HOME/.ripgrep.conf
