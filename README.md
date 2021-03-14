# dotfiles

This repository contains configuration files, Vimscript code and shell scripts for my software development environment.
The centrepieces of this environment are [kitty](https://sw.kovidgoyal.net/kitty/) and [Tmux](https://github.com/tmux/tmux) running one [Neovim](https://neovim.io/) instance and any number of zsh shells per project.

At the moment, the configuration is tailored to developing in Python, PHP, Go, and (to a lesser extent - more focused on reading) JavaScript and TypeScript.

These dotfiles are being used and hence tested only on GNU/Linux. MacOS is no longer supported.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Dependencies](#dependencies)
  - [Optional](#optional)
  - [Fonts](#fonts)
- [Installation](#installation)
  - [Themes](#themes)
  - [Config packages](#config-packages)
  - [Updating](#updating)
- [Custom configuration](#custom-configuration)
  - [Neovim](#neovim)
  - [Language Servers (LSPs)](#language-servers-lsps)
  - [isort](#isort)
  - [universal-ctags](#universal-ctags)
  - [Phpactor](#phpactor)
- [Linting VimL scripts](#linting-viml-scripts)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Dependencies

 * zsh
 * [Stow](http://www.gnu.org/software/stow/)
 * [kitty](https://sw.kovidgoyal.net/kitty/)
 * [Tmux](https://github.com/tmux/tmux)
 * [Neovim](https://neovim.io/) >= 0.5.0
 * OpenSSH
 * git
 * GnuPG
 * Python 3.8 and pip
 * Node >= 12.0.0
 * Yarn
 * [ripgrep](https://github.com/BurntSushi/ripgrep)
 * [universal-ctags](http://ctags.io/)
 * [tig](https://jonas.github.io/tig/)

### Optional

The following dependencies are _optional_ and enable additional functionality, mostly in Neovim.

 * Go (Golang)
 * PHP 7
 * Composer
 * [restic](https://restic.github.io/)

### Fonts

The kitty configuration relies on [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono) to be available and will enable its font ligatures.

## Installation

 * In the repo, execute `git submodule update --init`.
 * Edit `~/.zshenv` to read `export ZDOTDIR="$HOME/my-repos/dotfiles/zsh"` (adapt directory).
 * Execute `config-install.sh` to install all [config packages](#config-packages).
 * Opening Neovim for the first time will install _vim-plug_ and all plugins.
 * In Tmux, execute `prefix` + <kbd>I</kbd>.

### Themes

Multiple themes are supported by installing specific config file variants for the desired theme. This way colours are configured for kitty, zsh, Tmux, Neovim and FZF.

These files are installed through the `config-install.sh` script. Pass the theme name as first argument to the script to install a specific one.

The following themes are available:

* `base16-bright` (default)
* `papercolor`

### Config packages

The following (Stow based) config packages are available:

* `git`
* `kitty`
* `nvim`
* `ssh`
* `tig`
* `tmux`

By default, running `config-install.sh` installs all of them.
If you wish to only install specific packages, pass them as a second argument (after the theme name) to the script.
Separate multiple packages using commas: `config-install.sh papercolor ssh,git`.

**Note**: zsh is not installed as a package and is not optional.

### Updating

While in Neovim, execute regularly:

```
:PlugUpgrade
:PlugUpdate
```

In Tmux, execute `prefix` + <kbd>U</kbd> regularly.

## Custom configuration

Some projects require or can benefit from some custom configuration for some of the tools used in this development set-up.

### Neovim

Project local configuration can be set in `.lvimrc`. This allows for example to alter the set and configuration of linters being used by ALE, the Python test tool and its executable, and the PHP executable used by Phpactor:

```viml
let g:ale_linters = {
    \ 'php': ['php']
\ }
let g:ale_php_php_executable = '/usr/local/bin/php'

let g:test#python#runner = 'pytest'
let g:test#python#pytest#executable = 'make'

let g:phpactorPhpBin = '/usr/local/bin/php'
```

### Language Servers (LSPs)

All [language servers](https://langserver.org/) are currently installed and maintained using [coc.nvim](https://github.com/neoclide/coc.nvim) and are configured in `nvim/.config/nvim/coc-settings.json`. Project specific settings can be added in the project's `.vim/coc-settings.json` file.

The example below configures Pyright to treat a local directory as an extra root path for Python analysis:

```json
{
    "python.analysis.extraPaths": ["my_project"]
}
```

### isort

Sorting Python imports happens through [isort](https://pycqa.github.io/isort/) and is triggered using <kbd>&lt;Space&gt;so</kbd> in normal mode.

isort specific configuration can be set per project in a `pyproject.toml` file (as specified in [PEP 518](https://www.python.org/dev/peps/pep-0518/)):

```toml
[tool.isort]
known_first_party = ['my_module']
line_length = 99
```

### universal-ctags

Aside from common global configuration options set in `nvim/.config/ctags/global.ctags`, additional project-level parameters can be defined within `.ctags.d/*.ctags` files. This allows to exclude i.e. compiled or vendor source files using more `--exclude=` options.

### Phpactor

Additionally to settings in `nvim/.config/phpactor/phpactor.yml`, config options can be set per project in a `.phpactor.yml` file. For example, to change the project's PHP version, override the default indentation to tabs and change the path to Composer's autoloader:

```yaml
php.version: "7.3.0"
code_transform.indentation: "	"
composer.autoloader_path: %project_root%/dependencies/autoload.php
```

## Linting VimL scripts

Vimscript files can be linted using [Vint](https://github.com/Vimjas/vint).

To lint all VimL files, run `make lint`.
