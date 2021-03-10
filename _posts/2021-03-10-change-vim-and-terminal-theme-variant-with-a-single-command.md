---
layout: post
title: Change vim and terminal theme variant with a single command
---

During the day I prefer a light theme, and during the evening a dark one. I'm
currently using the Solarized theme, which has great light and dark variants.
With the following setup, I can switch the theme for both vim and terminal with
a single command.

```
#!/usr/bin/env bash

if [ "$1" == "dark" ]; then
  sed -i 's/background=light/background=dark/g' ~/.vimrc
  sed -i 's/\*themeLight/*themeDark/g' ~/code/dotfiles/alacritty.yml
else
  sed -i 's/background=dark/background=light/g' ~/.vimrc
  sed -i 's/\*themeDark/*themeLight/g' ~/code/dotfiles/alacritty.yml
fi
```

I've named this script `setbg` and can be used with `setbg dark` and
`setbg light`.

I use Alacritty as my terminal, and for it to work I've setup yaml aliases for
the light and dark solarized themes in my Alacritty config. Here is an excerpt:

``` yaml
schemes:
  solarized-light: &themeLight
    primary:
      background: '#fdf6e3' # base3
      ...

  solarized-dark: &themeDark
    primary:
      background: '#002b36' # base03
      ...
```

Check out the full Alacritty config
[here](https://github.com/thejspr/dotfiles/blob/master/alacritty.yml).

Next up is writing a cron job that switches to dark in the afternoon and light
in the morning :)
