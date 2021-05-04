.PHONY: lint-vim

vimfiles := $(shell git ls-files *.vim)

lint-vim:
	vint $(vimfiles)
