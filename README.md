# dotfiles

This repository contains configuration files, Vimscript and [Lua](https://neovim.io/doc/user/lua.html) code, and shell scripts for my software development environment on Linux.
The centrepieces of this environment are [kitty](https://sw.kovidgoyal.net/kitty/) and [Tmux](https://github.com/tmux/tmux) running one [Neovim](https://neovim.io/) instance and any number of zsh shells per project.

At the moment, the configuration is tailored to developing in Python, PHP, Go, JavaScript and TypeScript.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Dependencies](#dependencies)
  - [Optional](#optional)
- [Installation](#installation)
  - [Themes](#themes)
  - [Config packages](#config-packages)
  - [Updating](#updating)
- [Language Servers (LSP)](#language-servers-lsp)
- [Custom configuration](#custom-configuration)
  - [Neovim](#neovim)
  - [git](#git)
  - [isort](#isort)
  - [universal-ctags](#universal-ctags)
  - [Phpactor](#phpactor)
- [Linting source files](#linting-source-files)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Dependencies

The following is required for installing and using these dotfiles:

 * git
 * zsh
 * Bash
 * Python >= 3.8 and pip
 * [Stow](http://www.gnu.org/software/stow/)

### Optional

Depending on which [config packages](#config-packages) are installed, these dependencies are also required:

 * `git`:
     * GnuPG
     * [Delta](https://github.com/dandavison/delta)
 * `kitty`
     * [kitty](https://sw.kovidgoyal.net/kitty/)
     * [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono)
 * `nvim`
     * [Neovim](https://neovim.io/) HEAD (>= 0.6.0) -- see [install instructions](https://github.com/neovim/neovim/wiki/Installing-Neovim)
     * [ripgrep](https://github.com/BurntSushi/ripgrep)
     * [universal-ctags](http://ctags.io/)
     * _Optional_
         * Go (Golang)
         * PHP 7 and Composer
         * [Pyright](https://github.com/Microsoft/pyright) (for Python intelligence)
         * [Intelephense](https://intelephense.com/) (for PHP intelligence)
         * TypeScript and [TypeScript Language Server](https://github.com/theia-ide/typescript-language-server) (for TypeScript and JavaScript intelligence)
         * [.NET SDK](https://docs.microsoft.com/en-us/dotnet/core/sdk) 5.0 and [FsAutoComplete](https://github.com/fsharp/FsAutoComplete) (for F# intelligence)
 * `ssh`: OpenSSH
 * `tig`: [tig](https://jonas.github.io/tig/)
 * `tmux`: [Tmux](https://github.com/tmux/tmux)

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

* `papercolor` (default)
* `base16-bright`

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

### Updating

While in Neovim, execute regularly:

```
:PlugUpgrade
:PlugUpdate
```

In Tmux, execute `prefix` + <kbd>U</kbd> regularly.

## Language Servers (LSP)

Neovim's internal LSP client is used to provide code intelligence and completion using [language servers](https://langserver.org/).

Depending on the languages used, the following language server binaries need to be installed manually:

* Python ([Pyright](https://github.com/Microsoft/pyright)): `npm i -g pyright`
* PHP ([Intelephense](https://intelephense.com/)): `npm i -g intelephense`
* TypeScript and JavaScript ([tsserver](https://github.com/theia-ide/typescript-language-server)): `npm install -g typescript typescript-language-server`
* F# ([FsAutoComplete](https://github.com/fsharp/FsAutoComplete)): `dotnet tool install --global fsautocomplete`

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

### git

A `git/local.inc` file can be used to set custom git configuration values.
Here you can use [conditional includes](https://git-scm.com/docs/git-config#_conditional_includes) to set configuration per directory:

```gitconfig
# vi: ft=gitconfig

[user]
	email = me@example.com
[includeIf "gitdir:~/foo/bar/"]
	path = ~/foo/bar/.gitconfig
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

## Linting source files

Vimscript files can be linted using [Vint](https://github.com/Vimjas/vint), while Lua files are linted using [Luacheck](https://github.com/luarocks/luacheck).

To lint all source files, run `make lint`. VimL or Lua files can be linted separately using `make lint-vim` or `make lint-lua`.

## License

Copyright 2021, Dietrich Moerman.

Released under the terms of the [MIT License](LICENSE).
