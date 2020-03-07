# dotfiles

## Dependencies

 * zsh
 * git
 * OpenSSH
 * GnuPG
 * Python
 * Node >= 8.10.0
 * Yarn
 * Neovim with Python extensions
 * PHP 7 (accessible at `/usr/local/bin/php`)
 * Composer
 * universal-ctags
 * [EditorConfig](http://editorconfig.org/) `editorconfig-core-c`
 * tig
 * fzf
 * ripgrep
 * tmux
 * Golang
 * [restic](https://restic.github.io/)

### Fonts

 * Meslo for Powerline

## Installation

 * In the repo, execute `git submodule update --init`.
 * Edit `~/.zshenv` to read `export ZDOTDIR="$HOME/my-repos/dotfiles/zsh"` (adapt directory).
 * Execute `config-install.sh`.
 * In Tmux, execute `prefix` + <kbd>I</kbd>.

### Updating

While in NVIM, execute regularly:

    :PlugUpgrade
    :PlugUpdate

In Tmux, execute `prefix` + <kbd>U</kbd> regularly.

## Linting VimL scripts

Vimscript files can be linted using [Vint](https://github.com/Vimjas/vint). Install the linter using:

    pip install --pre vim-vint

Then, lint all VimL files with `make lint`.
