---
layout: post
title: Ruby installations on steroids
tags: ruby
---

If you are using Ruby, chances are you're using Rbenv to manage Ruby installations.
This post concerns some plugins and tips to make Rbenv even more awesome.

<!-- more -->

Firstly, I highly recommend using [Rbenv](https://github.com/sstephenson/rbenv)
for managing your ruby installations. It's very custimizable and less intrusive than [RVM](http://rvm.io/).
To get started, install it via Homebrew

    brew install rbenv ruby-build


or explore alternative ways [here](https://github.com/sstephenson/rbenv#installation).

Rbenv adheres to the unix philosophy of doing one thing well, which is managing
Ruby installations. The responsibility of actually installing rubies is
delegated to [ruby-build](https://github.com/sstephenson/ruby-build).


## Automatic rehashing new gem binaries

When installing gems with binaries you need to run `rbend rehash` for your
shell to know about them. The
[rbenv-gem-rehash](https://github.com/sstephenson/rbenv-gem-rehash)
plug-in alleviates this by automatically rehashing newly installed binaries.

Install the plug-in and you're all set:

    git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash


## Add default gems for new rubies

If you're tired of having to install common gems like Bundler every time you
add a new version of Ruby,
[rbenv-default-gems](https://github.com/sstephenson/rbenv-default-gems) is for
you. It will install gems defined by you as part of doing `rbenv install`.

Install the plug-in:

    git clone https://github.com/sstephenson/rbenv-default-gems.git ~/.rbenv/plugins/rbenv-default-gems

Define a list of default gems in `~/.rbenv/default-gems` like so:

    bundler
    pry --pre
    pry-doc '~ 0.5'
    cheat

## Project specific environment variables

If you'd like to use some custom environment variables for a project,
[rbenv-vars](https://github.com/sstephenson/rbenv-vars) is a nice solution.

Install the plug-in:

  git clone https://github.com/sstephenson/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars

Define custom environment variables in a `.rbenv-vars`:

    RUBY_GC_HEAP_INIT_SLOTS=600000
    RUBY_GC_HEAP_FREE_SLOTS=600000
    RUBY_GC_HEAP_GROWTH_FACTOR=1.25
    RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000

This example will apply some [garbage collection tweaks](http://tmm1.net/ruby21-rgengc/)
when Ruby is run from this folder.

## Conclusion

Rbenv is a great customizable way of managing multiple ruby installations.  In
closing, I'd like to thank [Sam Stephenson](http://sstephenson.us) for it and
its associated plug-ins.
