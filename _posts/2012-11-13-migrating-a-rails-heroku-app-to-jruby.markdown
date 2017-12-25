---
layout: post
title: "Migrate Rails to JRuby on Heroku"
date: 2012-11-13 07:37
categories: jruby heroku
url: /2012/migrating-a-rails-heroku-app-to-jruby
---

[This talk](http://confreaks.com/videos/1235-aloharuby2012-why-jruby) by Charles
Nutter recently inspired me to move one of my personal projects to JRuby. The
app is fairly small, running Rails 3.2 using Postgresql, activemodel-serializers
and oAuth to name a few.

<!-- more -->

## Update 2013-09-10

Heroku now has a much better and updated guide for running your [Rails app with JRuby on Heroku](https://devcenter.heroku.com/articles/moving-an-existing-rails-app-to-run-on-jruby)

## Using JRuby on Heroku

In order for Heroku to use JRuby instead of MRI, I've added the following to my
`Gemfile` leveraging Bundler's `ruby` directive.

{% highlight ruby %}
ruby '1.9.3', engine: 'jruby', engine_version: '1.7.4'
{% endhighlight %}

To get JRuby 1.7.4 locally I used `rbenv install jruby-1.7.4`.

### Applying JRuby specific buildpack

For Heroku to get all the plumbing needed for JRuby setup, add this buildpack.

{% highlight ruby %}
heroku config:add BUILDPACK_URL=git://github.com/jruby/heroku-buildpack-jruby.git
{% endhighlight %}

**Note:** I'm not sure this buildpack is still required for JRuby Rails apps.

## JRuby specific gems

Because the `pg` gem (postgres driver) includes c-extensions, it will not work
nicely with JRuby. An alternative for JRuby is `jdbc-postgres`. Hence, I added the
following to my `Gemfile` replacing the `pg` gem.

{% highlight ruby %}
gem 'activerecord-jdbc-adapter'
gem 'activerecord-jdbcpostgresql-adapter'
gem 'jdbc-postgres'
{% endhighlight %}

I previously used Thin as the webserver for my app, but given my move to JRuby I
wanted a webserver which utilized threads better. I chose
[Trinidad](https://github.com/trinidad/trinidad) for this task as it appears to
perform quite well according to [this benchmark](http://carlhoerberg.github.com/blog/2012/03/31/jruby-application-server-benchmarks/).

Make the following changes to use Tinidad.

{% highlight ruby %}
# Gemfils
gem 'trinidad', require: nil

# Procfile
web: bin/trinidad -t -r -p $PORT -e $RACK_ENV
{% endhighlight %}

## Compiling assets

One final change I had to make was ensuring assets would compile properly using
JRuby. This require me to replace `therubyracer` with `therubyrhino`.

{% highlight ruby %}
# Gemfile
gem 'therubyrhino'

# config/application.rb
config.assets.initialize_on_precompile = false

# config/environments/production.rb
config.serve_static_assets = true
STDOUT.sync = true
config.logger = Logger.new(STDOUT)
{% endhighlight %}

For fast asset pre-compilation I've also added the Google Closure Compiler.

{% highlight ruby %}
gem 'closure-compiler', group: :assets

# config/environments/production.rb
config.assets.js_compressor = :closure
{% endhighlight %}

## Going threadsafe!

One final thing I wanted to change in order to leverage the JVM's concurrency
better, was to enable Rails to use multiple threads for requests by setting
`config.treadsafe!` in `config/environments/production.rb'`

## Issues

As I encounter issues I will update this section with a corresponding solution.

### /usr/bin/env: jruby: No such file or directory

Ensure that your `PATH` includes `jruby/bin`. To inspect whether it does you can
run `heroku run export` and to set it run `heroku config:add PATH="bin:jruby/bin:/usr/bin:/bin"`.

## Observations
Given my project only has two users I've yet to see any noticable differences
between MRI and JRuby for my site. One downside of the move however is that the
slug size has increased quite dramatically from around 20MB to 67MB. This only
affects app startup/scaling times and is most likely because the slug now
contains JRuby (JVM, etc).

I plan to write a follow up post once I've collected some data in NewRelic as to
how JRuby performs compared to MRI.
