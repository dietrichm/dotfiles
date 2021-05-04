.PHONY: lint-vim lint-lua

vimfiles := $(shell git ls-files *.vim)
luafiles := $(shell git ls-files *.lua)

lint-vim:
	vint $(vimfiles)

lint-lua:
	luacheck $(luafiles)
