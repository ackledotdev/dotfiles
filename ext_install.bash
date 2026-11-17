#!/usr/bin/env bash
#
# External install script. To be run on a
# machine that does not have the repo cloned.
#
# Author: Akhil Pillai @ackledotdev
# Created: November 17, 2026
# License: MIT

git clone --recurse-submodules https://github.com/ackledotdev/dotfiles.git

cd dotfiles || echo "Failed to cd into cloned directory." && exit 1

# run the install script with confirmation
make install-ext
