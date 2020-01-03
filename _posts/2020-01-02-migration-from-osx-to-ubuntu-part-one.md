---
layout: post
title: Migration from OSX to Ubuntu part one
---

After having worked solely on a mac since 2011, I've moved back to linux as my
main workstation. This series covers the issues I found along the way and how I
solved them. As to why I moved back, the biggest point was building a cheapish
pc with great specs.

## Ubuntu 19.10, gdm and nvidia issue

Installing ubuntu was pretty straight forward. I did however encounter an issue
where I could not login from the lock screen. It turned out to be the display
manager (gdm I think) wasn't playing nice with the nvidia drivers, so I switched
to lightdm and that fixed the issue.

## Alfred alternative

The best alternative to Alfred.app I found on linux is https://ulauncher.io/.
Works pretty well out of the box.

## Email and calendar

I was using Spark on the mac, and since they don't support linux I've switched
over to Mailspring. It's pretty nice so far, and I'm looking forward to their
calender integration shipping this year. All other calendar apps I've tried on
linux either doesn't work or looks really terrible.

## TablePlus

I've replaced TablePlus (database GUI) with DataGrip from jetbrains. It's also
non-free, but so far it seems to hold up pretty well.

## Open command

On mac I used `open` in many scripts to open a link or file. An linux equivalent
for this is `xdg-open`. Link it like this for a seamless experience:

`sudo ln -nfs /usr/bin/xdg-open /usr/bin/open`

## Other apps

I was pleasantly surprised that all the other apps I use the most work fine on
Ubuntu. That includes: Slack, Spotify, Todoist.

## The end

I will be posting more parts as I go down the *nix rabbithole.
