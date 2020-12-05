---
layout: post
title: Use sprockets for javascript in rails 6
---

The default way to handle javascript in Rails 6 is Webpack, via the webpacker
gem. This is great in many scenarios, but sometimes it just feels too much for a
simple app with some jquery plugins. The following steps will allow you to use
Sprockets as in Rails 5/4/3.

For new apps, pass `--skip-webpack-install` and you're good to go.

For existing apps follow these steps:

1. Remove the webpacker gem, `bundle install` and restart.
2. `yarn remove @rails/webpacker`.
3. `rm -r config/webpacker`.
4. `rm config/webpack.yml`.
5. Change any `javascript_pack_tag` to `javascript_include_tag`.
6. Create `app/assets/javascripts/application.js` and `//= require X` any libs you need.
7. Add `//= link_directory ../javascripts .js` to `app/assets/config/manifest.js`

You can still use yarn to handle the js dependencies. An example
`application.js` file from a recent project:

``` js
//= require jquery
//= require bootstrap/dist/js/bootstrap
//= require tablesorter
```

# Heroku compilation issues

Without the webpacker gem installed, if you are deploying on heroku, you will
need to add the nodejs buildpack to ensure your npm packages are installed
before the app is built:

`heroku buildpacks:add --index 1 heroku/nodejs`

Done and dusted.

