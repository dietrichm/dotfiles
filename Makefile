.PHONY: lint lint-lua

luafiles := $(shell git ls-files *.lua)

lint: lint-lua

lint-lua:
	luacheck $(luafiles)
