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

# install-ext is to be run from the ext_install shellscript.
# This adds a flag to the install script so it prompts
# for confirmation before overwriting existing files.
.PHONY: install-ext
install-ext:
	./install --from-ext