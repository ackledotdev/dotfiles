.PHONY: help
help:
	@echo 'make install      install the dotfiles'
	@echo 'make check        style check the files'
	@echo 'make save         commit and push dotfiles if modified'

.PHONY: check
check:
	bash -n bash* install
	./tools/style-check bash* install

.PHONY: install
install:
	./install

.PHONY: save
save:
	./commit_push
