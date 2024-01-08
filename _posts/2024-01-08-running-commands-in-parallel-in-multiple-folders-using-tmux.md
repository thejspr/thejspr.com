---
layout: post
title: Running commands in parallel in multiple folders using tmux
---

I have several Ruby apps that I wanted to update to Ruby 3.3.0, and wanted to run the same
commands in those folders instead of repeating the process for each app.

TMUX to the rescue! Open a pane for each app, and `cd` into each apps folder. Then issue
the tmux command (<ctrl-a> :) `setw synchronize-panes`. Now whatever you type on the
keyboard will get sent to all panes in the window. This made it easy to edit the ruby
version, commit and push the changes.

This is also useful if you want to run the same command on several servers. Open a pane
for each server, ssh into it, enable synchronization and start typing.
