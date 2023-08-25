.PHONY: lint lint-lua

lint: lint-lua

lint-lua:
	luacheck .
