# dotfiles

These dotfiles are being used and hence tested only on GNU/Linux. MacOS is no longer supported.

- [Dependencies](#dependencies)
  - [Optional](#optional)
  - [Fonts](#fonts)
- [Installation](#installation)
  - [Updating](#updating)
- [Custom configuration](#custom-configuration)
  - [Neovim](#neovim)
  - [Language Servers (LSPs)](#language-servers-lsps)
  - [universal-ctags](#universal-ctags)
  - [Phpactor](#phpactor)
- [Linting VimL scripts](#linting-viml-scripts)

## Dependencies

 * [kitty](https://sw.kovidgoyal.net/kitty/)
 * zsh
 * git
 * OpenSSH
 * GnuPG
 * Python 3.8
 * pip
 * Node >= 12.0.0
 * Yarn
 * Neovim >= 0.5.0
 * universal-ctags
 * tig
 * fzf
 * ripgrep
 * tmux

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
 * Execute `config-install.sh`.
 * Opening Neovim for the first time will install _vim-plug_ and all plugins.
 * In Tmux, execute `prefix` + <kbd>I</kbd>.

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

Project local configuration can be set in `.lvimrc`. This allows for example to alter the set and configuration of linters being used by ALE, and the PHP executable used by Phpactor:

```viml
let g:ale_linters = {
    \ 'php': ['php']
\ }
let g:ale_php_php_executable = '/usr/local/bin/php'
let g:phpactorPhpBin = '/usr/local/bin/php'
```

#### Test runner

Implemented as a set of auto loaded functions in `autoload/test_runner.vim`, the test runner executes the current test case or test method (using [coc.nvim](https://github.com/neoclide/coc.nvim)) in the next available Tmux pane (through [Vimux](https://github.com/benmills/vimux)).

Its behaviour is configured using these buffer level variables:

```viml
let b:test_runner_executable_case = 'runtests {file}'
let b:test_runner_executable_test = 'runtests {file} --filter={test}'

" Optional lambda to translate buffer filename into actual test case name.
let b:test_runner_filename_transformer = {file -> substitute(file, '/', '.', 'g')}
```

Projects that require custom test configuration can configure these settings in a `.lvimrc` as well.

### Language Servers (LSPs)

All [language servers](https://langserver.org/) are currently installed and maintained using [coc.nvim](https://github.com/neoclide/coc.nvim) and are configured in `nvim/coc-settings.json`. Project specific settings can be added in the project's `.vim/coc-settings.json` file.

The example below configures Pyright to treat a local directory as an extra root path for Python analysis:

```json
{
    "python.analysis.extraPaths": ["my_project"]
}
```

### isort

Sorting Python imports happens through [isort](https://pycqa.github.io/isort/) and is triggered using <kbd>&lt;Space&gt;si</kbd> in normal mode.

isort specific configuration can be set per project in a `pyproject.toml` file (as specified in [PEP 518](https://www.python.org/dev/peps/pep-0518/)):

```toml
[tool.isort]
known_first_party = ['my_module']
line_length = 99
```

### universal-ctags

Aside from common global configuration options set in `ctags/global.ctags`, additional project-level parameters can be defined within `.ctags.d/*.ctags` files. This allows to exclude i.e. compiled or vendor source files using more `--exclude=` options.

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
