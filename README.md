# 💻 dotfiles

This repository contains configuration files and [Lua](https://neovim.io/doc/user/lua.html) code for my programming environment on Linux.
The centrepieces of this environment are [kitty](https://sw.kovidgoyal.net/kitty/) and [Neovim](https://neovim.io/).

If you are looking for my Neovim config, you can find it in [`nvim/.config/nvim`](nvim/.config/nvim).

## Dependencies

The following is required for installing and using these dotfiles:

 * Linux
 * git
 * zsh
 * make
 * [Stow](http://www.gnu.org/software/stow/)

### Optional

[fzf](https://github.com/junegunn/fzf) will be used in zsh shells when installed (i.e. using a package manager).

Depending on which [config packages](#config-packages) are installed, these dependencies are also required:

 * `git`
     * GnuPG
     * [Delta](https://github.com/dandavison/delta)
     * [bat](https://github.com/sharkdp/bat) for updated syntax files
 * `kitty`
     * [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono)
 * `nvim`
     * [ripgrep](https://github.com/BurntSushi/ripgrep)
     * [wl-clipboard](https://github.com/bugaevc/wl-clipboard)

## Installation

 * In the repo, execute `git submodule update --init`.
 * Edit `~/.zshenv` to read `export ZDOTDIR="$HOME/repos/dotfiles/zsh"` (adapt directory).
 * Execute `make` in the repo to install all config packages.

### Config packages

Run `make list` to list the available packages.

If you wish to only install specific packages, pass them as additional arguments to make, i.e.: `make ssh git`.

### Updating

Run `nvim +PaqUpdate` to update all plugins.

## Custom configuration

### zsh

Given direnv is installed, specific environment variables can be exported in `.envrc` files which are loaded automatically upon entering the (sub)directory.

### Neovim

Project local configuration can be set in `.nvim.lua` or `.nvimrc`.
Here, any desired [Language Servers](https://langserver.org/) (LSP) can be configured and/or enabled. For example:

```lua
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
      hints = {
        compositeLiteralFields = true,
        parameterNames = true,
      },
    },
  },
})
vim.lsp.enable('gopls')
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

### universal-ctags

Additional project-level parameters can be defined within `.ctags.d/*.ctags` files.
This allows to exclude i.e. compiled or vendor source files using more `--exclude=` options.

## License

Copyright 2021, Dietrich Moerman.

Released under the terms of the [MIT License](LICENSE).
