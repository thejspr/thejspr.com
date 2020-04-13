---
layout: post
title: Using webpack-bundle-analyzer in rails
tags: rails javascript
---

If you are using webpack in Rails via Webpacker, then the webpack configuration
is not entirely straigtforward. Below is how I setup [Webpack Bundle
Analyzer](https://github.com/webpack-contrib/webpack-bundle-analyzer) in my
projects.

First, install the dependency `yarn add -D webpack-bundle-analyzer`.

Then add the following to yout webpack developmen configuration:
`config/webpack/development.js`:

``` javascript
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
environment.plugins.prepend("BundleAnalyzerPlugin", new BundleAnalyzerPlugin());
```

You will now get a nice visual overview of your bundles when you run
`./bin/webpack`.
