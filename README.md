# dotfiles

## Dependencies

 * zsh
 * git
 * OpenSSH
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
 * [restic](https://restic.github.io/)

### Fonts

 * Meslo for Powerline
 * Noto Mono

## Installation

 * In the repo, execute `git submodule update --init`.
 * Edit `~/.zshenv` to read `export ZDOTDIR="$HOME/my-repos/dotfiles/zsh"` (adapt directory).
 * Execute `config-install.sh`.
 * In NVIM, execute `:PlugInstall`.
 * In Tmux, execute `prefix` + <kbd>I</kbd>.

### Updating

While in NVIM, execute regularly:

    :PlugUpgrade
    :PlugUpdate

In Tmux, execute regularly:

    `prefix` + <kbd>U</kbd>
