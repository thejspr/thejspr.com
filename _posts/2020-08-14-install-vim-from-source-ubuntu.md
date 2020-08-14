---
layout: post
title: Install Vim from source on Ubuntu
---

The version of Vim in the apt repository is usually lagging a bit behind the
latest version, so to get on the bleeding edge of Vim, follow these steps.

1. Clone the source: `git clone git://github.com/vim/vim.git`
2. Configure the build: `cd vim && ./configure --with-features=huge --enable-rubyinterp --enable-pythoninterp`
3. Compile Vim: `make`
4. Copy Vim to the system folders: `sudo make install`
5. Confirm you are running the new version via `vim --version`

That's it. `:wq`
