.PHONY: lint

vimfiles := $(shell git ls-files *.vim)

lint:
	vint $(vimfiles)
