#!/usr/bin/env bash
#
# Commit and push changes with an automated commit message.
#
# Author: Akhil Pillai @ackledotdev
# Created: November 07, 2026
# License: MIT

git add *

changed_files=$(git diff --staged --name-only --ignore-submodules)
changed_file_count=$(wc -l <<< $changed_files)

if [[ -z $changed_files ]]; then
	echo "No changes to commit."
	exit 0
fi

m1="cli: $(date +%Y-%m-%d) - $changed_file_count file(s) changed"
m2="updates to: ${changed_files//$'\n'/', '}"

git commit -S -m "$m1" -m "$m2"

echo "$m2"

git push -q

echo "Pushed to branch $(git branch --show-current) of remote $(git remote get-url origin)"
