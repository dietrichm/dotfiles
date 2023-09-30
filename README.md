# 💻 dotfiles

This repository contains configuration files and [Lua](https://neovim.io/doc/user/lua.html) code for my programming environment on Linux.
The centrepieces of this environment are [kitty](https://sw.kovidgoyal.net/kitty/) running one [Neovim](https://neovim.io/) instance and any number of zsh shells per project.

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
  - [Switching servers](#switching-servers)
- [Custom configuration](#custom-configuration)
  - [Neovim](#neovim)
  - [zsh](#zsh)
  - [git](#git)
  - [universal-ctags](#universal-ctags)
- [Linting source files](#linting-source-files)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Screenshot

![kitty running Neovim and zsh while working on a software project](https://github.com/dietrichm/dotfiles/assets/214730/b53a9e18-07de-45bc-9ea6-b5f1186a866e)

## Dependencies

The following is required for installing and using these dotfiles:

 * Linux
 * git
 * zsh
 * make
 * [Stow](http://www.gnu.org/software/stow/)

### Optional

[fzf](https://github.com/junegunn/fzf) will be used when installed (i.e. using a package manager).

Depending on which [config packages](#config-packages) are installed, these dependencies are also required:

 * `dig`: [bind-utils](https://github.com/tigeli/bind-utils)
 * `direnv`: [direnv](https://direnv.net/)
 * `git`
     * GnuPG
     * [Delta](https://github.com/dandavison/delta)
 * `kitty`
     * [kitty](https://sw.kovidgoyal.net/kitty/)
     * [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono)
     * [Symbols Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases)
 * `nvim`
     * [Neovim](https://neovim.io/) >= 0.9.1
     * [ripgrep](https://github.com/BurntSushi/ripgrep)
     * [universal-ctags](http://ctags.io/)
     * _Optional_
         * Go (Golang) for use with [vim-go](https://github.com/fatih/vim-go)
         * [Language servers](#language-servers-lsp) depending on the desired languages
 * `ranger`: [ranger](https://github.com/ranger/ranger)
 * `ssh`: OpenSSH
 * `tig`: [tig](https://jonas.github.io/tig/)

## Installation

 * In the repo, execute `git submodule update --init`.
 * Edit `~/.zshenv` to read `export ZDOTDIR="$HOME/repos/dotfiles/zsh"` (adapt directory).
 * Execute `make` in the repo to install all [config packages](#config-packages).
 * Run `nvim +PaqInstall` to install all plugins. Ignore errors about missing ones before all have been installed.

### Themes

Multiple themes are supported by installing specific config file variants for the desired theme. This way colours are configured for kitty, zsh, Neovim and fzf.

These files are also installed through make. Pass the theme name as an argument to `make` to install a specific one.

Currently, I only use and maintain one theme:

* `default` (uses [Oh My Posh](https://ohmyposh.dev/) prompt in Kitty when installed)

### Config packages

The following (Stow based) config packages are available:

* `dig`
* `direnv`
* `git`
* `kitty`
* `nvim`
* `ranger`
* `ssh`
* `tig`

Running `make` installs all of them.
If you wish to only install specific packages, pass them as additional arguments (besides the theme name) to make, i.e.: `make default ssh git`.

Additionally, `make all` installs all config packages, which is useful when installing a specific theme along with all packages: `make theme-name all`.

### Updating

In Neovim, execute `:PaqUpdate`.

## Language Servers (LSP)

Neovim's internal LSP client is used to provide code intelligence and completion using [language servers](https://langserver.org/).

`gopls` (for Go) is installed through the [vim-go](https://github.com/fatih/vim-go) Neovim plugin (using `:GoInstallBinaries`).

Depending on the languages used, the following language server binaries need to be installed manually:

* Python ([Pyright](https://github.com/Microsoft/pyright)): `npm i -g pyright`
* PHP:
  * [Intelephense](https://intelephense.com/): `npm i -g intelephense`
  * [Phpactor](https://github.com/phpactor/phpactor) (started manually): see [installation instructions](https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation)
* TypeScript and JavaScript ([tsserver](https://github.com/theia-ide/typescript-language-server)): `npm i -g typescript typescript-language-server`
* Lua ([lua-language-server](https://github.com/luals/lua-language-server)): see [installation instructions](https://github.com/luals/lua-language-server/wiki/Getting-Started#command-line). Create the wrapper script as `~/bin/lua-language-server`.

### Switching servers

To disable current servers and start a single one, you can use `:LspSwitch <name>`.

This is especially useful for PHP, where only Intelephense is auto-started and you can switch to Phpactor using `:LspSwitch phpactor`.
The command also avoids the stopped servers from spinning up again when new buffers are loaded.

## Custom configuration

Some projects require or can benefit from some custom configuration for some of the tools used in this development set-up.

### Neovim

Project local configuration can be set in `.nvim.lua` or `.nvimrc`.
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

### universal-ctags

Aside from common global configuration options set in `nvim/.config/ctags/global.ctags`, additional project-level parameters can be defined within `.ctags.d/*.ctags` files. This allows to exclude i.e. compiled or vendor source files using more `--exclude=` options.

## Linting source files

Lua files are linted using [Luacheck](https://github.com/luarocks/luacheck).

To lint all source files, run `make lint`. Lua files can be linted separately using `make lint-lua`.

## License

Copyright 2021, Dietrich Moerman.

Released under the terms of the [MIT License](LICENSE).
