---
layout: post
title: Deploy Rails with PostgreSQL to Dokku
---

Dokku is a "Docker powered mini-Heroku in around 100 lines of Bash". It's really
awesome as it allows you to get your own application platform up and running
under an hour! In writing this post and trying out Dokku, I used an existing
Rails 4 application that is currently running on Heroku. Because the application
adheres to most of the concepts from the [12 factor
methodology](http://12factor.net/), I didn't have to change a single thing in the
application to get it running on Dokku. If you find your application relies too
much on server specifics, this might be a good time to take a look at the 12 factor
methodology.

This post covers the issues I met when deploying an existing Rails 4.1
application using PostgreSQL to a server running Dokku.

<!-- more -->

## Installing Dokku

You need a server with Dokku installed, I recommend following [this
guide](https://www.digitalocean.com/community/tutorials/how-to-use-the-dokku-one-click-digitalocean-image-to-run-a-node-js-app).
Alternatively, you can follow the steps on the [Dokku
wiki](https://github.com/progrium/dokku#installing).

In order to get up and running fast, I recommend using the Dokku image provided
by DigicalOcean. It's dead easy to get going, and can easily run on a small
droplet for $5 per month.

## Installing PostgreSQL

You can add a PostgreSQL container to your server by installing a [Dokku
plugin](https://github.com/Kloadut/dokku-pg-plugin). Once you have followed the
steps on the wiki, you're almost ready to deploy your application.

In order to install the `pg` gem, you need to ensure you have the PostgreSQL
libraries installed. On Ubuntu you can install them with this command:
`sudo apt-get install libpq-dev`.

When you have linked you database with the application, a `DATABASE_URL` is set
and Dokku will automatically change your Rails configuration on deploy to use that.

## Preparing your Rails application

First you need to add your Dokku server as a git remote:
`git remote add dokku dokku@<server>:<app-name>`, replacing `server` and
`app-name` with your Dokku server and application name.

You need to add a `Procfile` for Dokku to know how your application is started.
This is an example `Procfile` for a Rails application using Unicorn:

{% highlight ruby %}
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
{% endhighlight %}

## Setting application configuration variables

I'm using Dokku to setup a staging environment, so I need the server to have
specific environment variables set. This is easily done on the server by
running: `dokku config:set <app-name> rails_env=staging`

## Deploying to Dokku

You can now deploy your application via `git push dokku master`. This should
look very familiar if you've used Heroku before.

Once your app is deployed, you can migrate the database by SSH'ing onto the
server and running `dokku run <app-name> bundle exec rake db:migrate`.

By now you should have your app running on Dokku! The url is printed at the end
of the deployment.

### Dealing with memory issues on deploy

If you get an error like `cannot allocate memory` when installing gems, you need
to either upgrade your server to have more memory, or create a swap drive. I
found creating a swap drive the easiest approach:

{% highlight bash %}
dd if=/dev/zero of=/swapfile bs=1024 count=1024000
mkswap /swapfile
swapon /swapfile
{% endhighlight %}

## Conclusion

I hope this gave you a quick overview on how easy it is to get your own
mini-Heroku running using Dokku. For more advanced setups I'd recommend looking
at the documentation, and please share anything you find in the comments below.
