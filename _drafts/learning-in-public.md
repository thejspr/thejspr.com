---
layout: post
title: Learning in public
---

This is the beginning of an experiment concerned with me learning a new
technology and documenting my progress. In order to learn as much (and fast) as
possible, I will be "learning in public" in hopes that it will keep me focused
and that I might get some feedback from people passing by. The produced code is
[available for feedback on Github](http://github.com/thejspr/backboneindex).

## Learning Backbone.js

I have previously dabbled in EmberJS and Angular, but wanted to try out a less
magical and opinionated framework and chose [Backbone.js](http://backbonejs.org/).

Whilst looking around for a good resource for learning Backbone, I came upon
[backbonerails.com](http://www.backbonerails.com) which looked really promising.
It's a series of screencasts which starts with the basics of Backbone and then
moves on to building advanced features using Marionette.js.

After starting the course decided to build something useful as part of my
learning, and the product of this is [Backbone Index](http://backboneindex.com).
I just published the initial version of the site and plan to add more advanced
filtering and such as I progress in learning Backbone.

The first version is plain Backbone and pretty basic. It lists all plugins from
the [official Backbone wiki](https://github.com/jashkenas/backbone/wiki/Projects-and-Companies-using-Backbone)
and allows filtering by category. I plan to start using Marionette.js as I
develop new features, and write about my progress in doing so.

The current roadmap look like this:

* Backbone-only prototype with filter-by-category
* Migrate to Marionette.js and add an about page
* Migrate from Jekyll to [Yeoman](http://yeoman.io/)
* Refactor the application into CoffeeScript
* Add functionality to filter via a search field
* Add more pages from the Backbone wiki

For now, check out the first version of [Backbone Index](http://backboneindex.com),
and be sure to [check out the source](http://github.com/thejspr/backboneindex)
as well (feedback is more than welcome).
