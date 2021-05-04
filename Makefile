.PHONY: lint lint-vim lint-lua

vimfiles := $(shell git ls-files *.vim)
luafiles := $(shell git ls-files *.lua)

lint: lint-vim lint-lua

lint-vim:
	vint $(vimfiles)

lint-lua:
	luacheck $(luafiles)
