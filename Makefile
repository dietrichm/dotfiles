.PHONY: lint
lint: lint-lua

.PHONY: lint-lua
lint-lua:
	luacheck -q .
