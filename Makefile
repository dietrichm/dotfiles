PKG = stow -v -d "$(MY_CONFIG_ROOT)" -t "$(HOME)"

.PHONY: all
all: containers dig direnv git helix kitty nvim ranger ssh

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

.PHONY: helix
helix: env
	$(PKG) helix

.PHONY: kitty
kitty: env
	$(PKG) kitty

.PHONY: nvim
nvim: env $(HOME)/.local/share/nvim/site/pack/paqs/start/paq-nvim
	$(PKG) nvim
	@echo -e "\n❗ Neovim will now start and install all plug-ins. Quit when installation is finished.\n"
	@echo -n "Press Enter to continue."
	@read
	nvim +PaqInstall

.PHONY: ranger
ranger: env
	$(PKG) ranger

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
lint: lint-lua

.PHONY: lint-lua
lint-lua:
	luacheck -q .
	stylua --check --allow-hidden .
