Configuration Files
===================

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/ackledotdev/dotfiles/ci.yml?branch=master&label=format)

My custom config files and rcs.

Cloned from Dave Eddy's dotfiles repository and reconfigured.

If you are not me, you should reconfigure this too.

Installation
------------

Quick install (designed for new/remote machines):
```bash
$ curl -Ls --show-error https://ackle.dev/scripts/dotfiles/install | bash
```
This script runs the install script (described below) __with a confirmation prompt__.

Inside the repository you can run `./install.bash` or the Makefile script to
place the configs in `~`. This will symlink them from the repository, so you
can easily update with `git pull`.

This also does some basic setup (i.e. installing [bics](https://github.com/bahamas10/bics))
that you may or may not want. Read the script.

**Caution: Running the install script overwrites files without prompting.**

```bash
$ make install
```

Development
-----------

Make sure the code passes the style checks with:

```bash
$ make check
```
