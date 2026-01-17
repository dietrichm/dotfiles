PKG = stow -v -d "$(MY_CONFIG_ROOT)" -t "$(HOME)"

.PHONY: all
all: containers dig direnv git kitty nvim ssh

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
nvim: env $(HOME)/.local/share/nvim/site/pack/paqs/start/paq-nvim
	$(PKG) nvim
	@echo -e "\n⚠️ Neovim will now start and install all plug-ins. Quit when installation is finished.\n"
	@echo -n "Press Enter to continue."
	@read
	nvim +PaqInstall

.PHONY: ssh
ssh: env
	$(PKG) ssh

.PHONY: env
env:
ifndef MY_CONFIG_ROOT
	$(error Please follow install instructions in README.md first)
endif

$(HOME)/.local/share/nvim/site/pack/paqs/start/paq-nvim:
	git clone --depth=1 https://github.com/savq/paq-nvim.git "$@"

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
		--output ~/bin/nv-new
	mv --backup=numbered ~/bin/nv-new ~/bin/nv
	chmod u+x ~/bin/nv
	ls -1v ~/bin/nv.~*~ | head -n -5 | xargs rm
	@echo
	@nv --version

.PHONY: nvim-configs.tar.gz
nvim-configs.tar.gz: ROOT ?= $(HOME)/repos
nvim-configs.tar.gz: FILES = $(shell find $(ROOT) -name .nvimrc -o -name .nvim.lua)
nvim-configs.tar.gz:
	tar czPf $@ $(FILES)
