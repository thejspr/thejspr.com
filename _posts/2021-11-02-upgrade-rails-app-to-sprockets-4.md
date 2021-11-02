---
layout: post
title: Upgrade rails app to sprockets 4
---

Sprockets 4 has a new way of handling which files to compile, which requires a
bit of setup.

Add a file `app/assets/config/manifest.js` with this content:

``` js
//= link_tree ../images
//= link application.css
//= link application.js
```

This will work with a standard setup, but you might need more links if you have
a differen setup.

You can now remove any additions to `config.assets.precompile` you may have.

More information can be found here:
https://github.com/rails/sprockets/blob/master/UPGRADING.md

