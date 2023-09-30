THEME = stow -v --override='.*' -d "$(MY_CONFIG_ROOT)/themes"
PKG = stow -v -d "$(MY_CONFIG_ROOT)" -t "$(HOME)"

.PHONY: install
install: default all

.PHONY: default
default: env
	$(THEME) default

.PHONY: all
all: dig direnv git kitty nvim ranger ssh tig

.PHONY: dig
dig: env
	$(PKG) dig

.PHONY: direnv
direnv: env
	$(PKG) direnv

.PHONY: git
git: env
	$(PKG) git

.PHONY: kitty
kitty: env
	$(PKG) kitty

.PHONY: nvim
nvim: env $(HOME)/.local/share/nvim/site/pack/paqs/start/paq-nvim
	$(PKG) nvim

.PHONY: ranger
ranger: env
	$(PKG) ranger

.PHONY: ssh
ssh: env
	$(PKG) ssh

.PHONY: tig
tig: env
	$(PKG) tig

.PHONY: env
env:
ifndef MY_CONFIG_ROOT
	$(error Please follow install instructions in README.md first)
endif

$(HOME)/.local/share/nvim/site/pack/paqs/start/paq-nvim:
	git clone --depth=1 https://github.com/savq/paq-nvim.git "$@"

.PHONY: lint
lint: lint-lua

.PHONY: lint-lua
lint-lua:
	luacheck -q .
