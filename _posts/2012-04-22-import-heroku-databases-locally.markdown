---
layout: post
title: "Import Heroku databases locally"
date: 2012-04-22 12:10
comments: true
categories: heroku devops postgresql
url: /2012/import-heroku-databases-locally
---

I just discovered a way simpler solution. Add the `taps` gem to your Gemfile,
and run `heroku db:pull`. Voila!

<!-- more -->

## Long (non-rails) version

I recently started a pet-project which emails me a random piece of text
each day, to remind me of something. I am making this as I often read something
which gives an insight that I want to be reminded of in the future, for it to be
properly 'persisted' in my brain. Stay posted for the MVP.

### Backing up Postgres on Heroku

First you need to add the PG Backups addon to your app:

{% highlight ruby %}
heroku addons:add pgbackups:auto-month
{% endhighlight %}

The auto-month plan is currently free, but in case that changes you can see the
other plans at [https://addons.heroku.com/pgbackups](https://addons.heroku.com/pgbackups)

With the addon installed you can now run the following script to import your
production postgres database into you local postgres database.

{% highlight bash %}
#!/bin/bash

heroku pgbackups:capture --expire

curl -o latest.dump `heroku pgbackups:url`

pg_restore --clean --no-acl --no-owner -h localhost -U <username> -d <database> latest.dump
{% endhighlight %}

Remember to replace the username and database parameters.

In case you don't want to be asked for a password every time, you can create a
`~/.pgpass` file containing you Postgres details using the following format:
`hostname:port:database:username:password`. Give that file `chmod 0600 ~/.pgpass`
permissions and add the parameter `-w` to the script above.
