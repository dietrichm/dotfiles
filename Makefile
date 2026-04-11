PKG = stow -v -d "$(MY_CONFIG_ROOT)" -t "$(HOME)"
MAKEFLAGS += --no-print-directory

.PHONY: all
all: containers dig direnv git kitty nvim

.PHONY: list
list:
	@grep -F '$$(PKG)' Makefile | grep -v @grep | awk '{print $$2;}'

.PHONY: containers
containers: env
	$(PKG) containers

.PHONY: dig
dig: env
	$(PKG) dig

.PHONY: direnv
direnv: env
	$(PKG) direnv

.PHONY: git
git: env
	$(PKG) git
	-bat cache --build

.PHONY: kitty
kitty: env
	$(PKG) kitty

.PHONY: nvim
nvim: env
	$(PKG) nvim

.PHONY: env
env:
ifndef MY_CONFIG_ROOT
	$(error Please follow install instructions in README.md first)
endif

.PHONY: lint
lint:
	luacheck -q .
	stylua --check --allow-hidden .

.PHONY: update-nvim-nightly
update-nvim-nightly:
	gh \
		--repo neovim/neovim \
		release download nightly \
		--pattern nvim-linux-x86_64.appimage \
		--output ~/bin/nvim-new
	mv --backup=numbered ~/bin/nvim-new ~/bin/nvim
	chmod u+x ~/bin/nvim
	ls -1v ~/bin/nvim.~*~ | head -n -5 | xargs -r rm
	@echo
	@~/bin/nvim --version

.PHONY: nvim-configs.tar.gz
nvim-configs.tar.gz: ROOT ?= $(HOME)/repos
nvim-configs.tar.gz: FILES = $(shell find $(ROOT) -name .nvimrc -o -name .nvim.lua)
nvim-configs.tar.gz:
	tar czPf $@ $(FILES)
