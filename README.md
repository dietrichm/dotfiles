# dotfiles

## Dependencies

 * [kitty](https://sw.kovidgoyal.net/kitty/)
 * zsh
 * git
 * OpenSSH
 * GnuPG
 * Python 3.8
 * pip
 * Node >= 8.10.0
 * Yarn
 * Neovim >= 0.5.0
 * PHP 7
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

The kitty configuration relies on [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono) to be available and will enable its font ligatures.

## Installation

 * In the repo, execute `git submodule update --init`.
 * Edit `~/.zshenv` to read `export ZDOTDIR="$HOME/my-repos/dotfiles/zsh"` (adapt directory).
 * Execute `config-install.sh`.
 * In Tmux, execute `prefix` + <kbd>I</kbd>.

### Updating

While in NVIM, execute regularly:

```
:PlugUpgrade
:PlugUpdate
```

In Tmux, execute `prefix` + <kbd>U</kbd> regularly.

## Custom configuration

Some projects require or can benefit from some custom configuration for some of the tools used in this development set-up.

### Neovim

Project local configuration can be set in `.lvimrc`. This allows for example to alter the set and configuration of linters being used by ALE, and the PHP executable used by Phpactor:

```viml
let g:ale_linters = {
    \ 'php': ['php']
\ }
let g:ale_php_php_executable = '/usr/local/bin/php'
let g:phpactorPhpBin = '/usr/local/bin/php'
```

### universal-ctags

Aside from common global configuration options set in `.ctags`, additional project-level parameters can be defined within `.ctags.d/*.ctags` files. This allows to exclude i.e. compiled or vendor source files using more `--exclude=` options.

### Phpactor

Additionally to settings in `phpactor/phpactor.yml`, config options can be set per project in a `.phpactor.yml` file. For example, to change the project's PHP version, override the default indentation to tabs and change the path to Composer's autoloader:

```yaml
php.version: "7.3.0"
code_transform.indentation: "	"
composer.autoloader_path: %project_root%/dependencies/autoload.php
```

## Linting VimL scripts

Vimscript files can be linted using [Vint](https://github.com/Vimjas/vint).

To lint all VimL files, run `make lint`.
