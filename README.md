# 💻 dotfiles

This repository contains configuration files, Vimscript and [Lua](https://neovim.io/doc/user/lua.html) code, and shell scripts for my programming environment on Linux.
The centrepieces of this environment are [kitty](https://sw.kovidgoyal.net/kitty/) and [Tmux](https://github.com/tmux/tmux) running one [Neovim](https://neovim.io/) instance and any number of zsh shells per project.

If you are looking for my Neovim config, you can find it in [`nvim/.config/nvim`](nvim/.config/nvim).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Screenshot](#screenshot)
- [Dependencies](#dependencies)
  - [Optional](#optional)
- [Installation](#installation)
  - [Themes](#themes)
  - [Config packages](#config-packages)
  - [Updating](#updating)
- [Language Servers (LSP)](#language-servers-lsp)
- [Custom configuration](#custom-configuration)
  - [Neovim](#neovim)
  - [zsh](#zsh)
  - [git](#git)
  - [isort](#isort)
  - [universal-ctags](#universal-ctags)
- [Linting source files](#linting-source-files)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Screenshot

![Tmux running Neovim while working on a software project](https://repository-images.githubusercontent.com/222291363/62316e00-9b8e-11eb-85a4-74bf9b11aeda)

## Dependencies

The following is required for installing and using these dotfiles:

 * Linux
 * git
 * zsh
 * Bash
 * Python >= 3.8 and pip
 * [Stow](http://www.gnu.org/software/stow/)

### Optional

Depending on which [config packages](#config-packages) are installed, these dependencies are also required:

 * `dig`: [bind-utils](https://github.com/tigeli/bind-utils)
 * `direnv`: [direnv](https://direnv.net/)
 * `git`
     * GnuPG
     * [Delta](https://github.com/dandavison/delta)
 * `kitty`
     * [kitty](https://sw.kovidgoyal.net/kitty/)
     * [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono)
 * `nvim`
     * [Neovim](https://neovim.io/) HEAD -- see [install instructions](https://github.com/neovim/neovim/wiki/Installing-Neovim)
     * [fd](https://github.com/sharkdp/fd)
     * [ripgrep](https://github.com/BurntSushi/ripgrep)
     * [universal-ctags](http://ctags.io/)
     * _Optional_
         * Go (Golang) -- will install [vim-go](https://github.com/fatih/vim-go)
         * [Language servers](#language-servers-lsp) depending on the desired languages
 * `ssh`: OpenSSH
 * `tig`: [tig](https://jonas.github.io/tig/)
 * `tmux`: [Tmux](https://github.com/tmux/tmux)

## Installation

 * In the repo, execute `git submodule update --init`.
 * Edit `~/.zshenv` to read `export ZDOTDIR="$HOME/repos/dotfiles/zsh"` (adapt directory).
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

* `dig`
* `direnv`
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

`gopls` (for Go) is installed by default through the [vim-go](https://github.com/fatih/vim-go) Neovim plugin.

Depending on the languages used, the following language server binaries need to be installed manually:

* Python ([Pyright](https://github.com/Microsoft/pyright)): `npm i -g pyright`
* PHP (desired server must be manually started using `:LspStart`):
  * [Intelephense](https://intelephense.com/): `npm i -g intelephense`
  * [Phpactor](https://github.com/phpactor/phpactor): see [installation instructions](https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation)
* TypeScript and JavaScript ([tsserver](https://github.com/theia-ide/typescript-language-server)): `npm i -g typescript typescript-language-server`
* Lua ([lua-language-server](https://github.com/luals/lua-language-server)): see [installation instructions](https://github.com/luals/lua-language-server/wiki/Getting-Started#command-line). Create the wrapper script as `~/bin/lua-language-server`.

## Custom configuration

Some projects require or can benefit from some custom configuration for some of the tools used in this development set-up.

### Neovim

Project local configuration can be set in `.lvimrc`.
This allows for example to set the default Python test tool and its executable:

```viml
let g:test#python#runner = 'pytest'
let g:test#python#pytest#executable = 'make'
```

### zsh

Specific environment variables can be exported in `.envrc` files which are loaded automatically upon entering the (sub)directory.

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

Sorting Python imports happens through [isort](https://pycqa.github.io/isort/) and is triggered using <kbd>&lt;Space&gt;lf</kbd> (lint-fix or formatting) in normal mode.

isort specific configuration can be set per project in a `pyproject.toml` file (as specified in [PEP 518](https://www.python.org/dev/peps/pep-0518/)):

```toml
[tool.isort]
known_first_party = ['my_module']
line_length = 99
```

### universal-ctags

Aside from common global configuration options set in `nvim/.config/ctags/global.ctags`, additional project-level parameters can be defined within `.ctags.d/*.ctags` files. This allows to exclude i.e. compiled or vendor source files using more `--exclude=` options.

## Linting source files

Vimscript files can be linted using [Vint](https://github.com/Vimjas/vint), while Lua files are linted using [Luacheck](https://github.com/luarocks/luacheck).

To lint all source files, run `make lint`. VimL or Lua files can be linted separately using `make lint-vim` or `make lint-lua`.

## License

Copyright 2021, Dietrich Moerman.

Released under the terms of the [MIT License](LICENSE).
