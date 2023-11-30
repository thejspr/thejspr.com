---
layout: post
title: i3 tips and tricks
---

I've been using the I3 window manager for a while now and now find no way of going back to
a non-tiling window manager. Below are some tips and tricks I've picked up along the way.

## Moving a floating window

With `floating_modifier $mod` set, you can move floating windows around with the mouse
when holding down the mod key.

## Shared config with extras per machine

Add this to your config.

`include ~/dotfiles/i3/`hostname`.conf`

Now you can have specific config in the files `~/dotfiles/i3/laptop.conf` and
`~/dotfiles/i3/desktop.conf`.

## Run commands on startup when the network is available

Starting some apps before the network is ready will cause rendering issues for images etc.
Using `nm-online` you can run the command when the connection is ready:

```
set $connectCheck nm-online --quiet --timeout=300
exec $connectCheck && slack
exec $connectCheck && google-chrome
```

## More tips and tricks

Find all of my config in [my dotfiles](https://github.com/thejspr/dotfiles/i3).
