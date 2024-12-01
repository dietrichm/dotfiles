# 💻 dotfiles

This repository contains configuration files and [Lua](https://neovim.io/doc/user/lua.html) code for my programming environment on Linux.
The centrepieces of this environment are [kitty](https://sw.kovidgoyal.net/kitty/) running one [Neovim](https://neovim.io/) instance and any number of zsh shells per project.

If you are looking for my Neovim config, you can find it in [`nvim/.config/nvim`](nvim/.config/nvim).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Dependencies](#dependencies)
  - [Optional](#optional)
- [Installation](#installation)
  - [Config packages](#config-packages)
  - [Updating](#updating)
- [Language Servers (LSP)](#language-servers-lsp)
- [Custom configuration](#custom-configuration)
  - [Neovim](#neovim)
  - [zsh](#zsh)
  - [git](#git)
  - [universal-ctags](#universal-ctags)
- [Linting source files](#linting-source-files)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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

 * `containers`: [Podman](https://podman.io/)
 * `dig`: [bind-utils](https://github.com/tigeli/bind-utils)
 * `direnv`: [direnv](https://direnv.net/)
 * `git`
     * GnuPG
     * [Delta](https://github.com/dandavison/delta) (with optional [bat](https://github.com/sharkdp/bat) for updated syntax files)
     * [tig](https://jonas.github.io/tig/)
 * `helix`: [Helix](https://helix-editor.com/)
 * `kitty`
     * [kitty](https://sw.kovidgoyal.net/kitty/)
     * [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono)
     * [Symbols Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases)
 * `nvim`
     * [Neovim](https://neovim.io/) 0.10
     * [ripgrep](https://github.com/BurntSushi/ripgrep)
     * [universal-ctags](http://ctags.io/)
     * _Optional_
         * Go (Golang) for use with [vim-go](https://github.com/fatih/vim-go)
         * [Language servers](#language-servers-lsp) depending on the desired languages
 * `ranger`: [ranger](https://github.com/ranger/ranger)
 * `ssh`: OpenSSH

## Installation

 * In the repo, execute `git submodule update --init`.
 * Edit `~/.zshenv` to read `export ZDOTDIR="$HOME/repos/dotfiles/zsh"` (adapt directory).
 * Execute `make` in the repo to install all [config packages](#config-packages).

### Config packages

The following (Stow based) config packages are available:

* `containers`
* `dig`
* `direnv`
* `git`
* `helix`
* `kitty`
* `nvim`
* `ranger`
* `ssh`

Running `make` installs all of them.
If you wish to only install specific packages, pass them as additional arguments to make, i.e.: `make default ssh git`.

### Updating

Run `nvim +PaqUpdate` to update all plugins.

## Language Servers (LSP)

Neovim's internal LSP client is used to provide code intelligence and completion using [language servers](https://langserver.org/).

`gopls` (for Go) is installed through the [vim-go](https://github.com/fatih/vim-go) Neovim plugin (using `:GoInstallBinaries`).

Depending on the languages used, the following language server binaries need to be installed manually:

* Python ([Basedpyright](https://docs.basedpyright.com/)): `pip install basedpyright`
* PHP ([Intelephense](https://intelephense.com/)): `npm i -g intelephense`
* TypeScript and JavaScript ([TypeScript Language Server](https://github.com/typescript-language-server/typescript-language-server)): `npm i -g typescript typescript-language-server`
* Lua ([lua-language-server](https://github.com/luals/lua-language-server)): see [installation instructions](https://github.com/luals/lua-language-server/wiki/Getting-Started#command-line). Create the wrapper script as `~/bin/lua-language-server`.
* Markdown ([Marksman](https://github.com/artempyanykh/marksman)): see [installation instructions](https://github.com/artempyanykh/marksman/blob/main/docs/install.md)
* Tailwind CSS ([tailwindcss/language-server](https://github.com/tailwindlabs/tailwindcss-intellisense)): `npm i -g @tailwindcss/language-server`

## Custom configuration

Some projects require or can benefit from some custom configuration for some of the tools used in this development set-up.

### Neovim

Project local configuration can be set in `.nvim.lua` or `.nvimrc`.
Neovim also reads [EditorConfig](https://editorconfig.org/) files.

### zsh

Given direnv is installed, specific environment variables can be exported in `.envrc` files which are loaded automatically upon entering the (sub)directory.

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

Lua files in this repository are linted using [Luacheck](https://github.com/luarocks/luacheck) and [StyLua](https://github.com/JohnnyMorganz/StyLua).
You need to install these tools yourself.

To lint all Lua files, run `make lint` or `make lint-lua`.

## License

Copyright 2021, Dietrich Moerman.

Released under the terms of the [MIT License](LICENSE).
