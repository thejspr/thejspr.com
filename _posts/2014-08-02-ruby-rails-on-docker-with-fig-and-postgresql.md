---
layout: post
title: Rails with PostgreSQL on Docker using Fig
tags: rails devops
---

**Update 20/01-16:** Updated installation instructions for the latest versions of
Docker, Fig and Ruby.

Docker is a platform for building, shipping and running all sorts of
applications [(source)](https://www.docker.com/whatisdocker/). It's a very
powerful and extensible alternative to other forms of virtualization and
platforms like Heroku. This post described the steps I've taken to get an
existing Rails app onto Docker using Fig.

<!-- more -->


## Installing Docker

There are many guides on installing Docker. I recommend starting
[here](https://docs.docker.com/installation/#installation). The rest of
this guide assumes you have Docker setup and running locally.


## Ruby 2.2.0 Dockerfile

Copy the following into a `Dockerfile` and run `docker build .` to start
building the container. Once successful, try running the same command to see
that Docker properly caches the build so it is done in seconds.

{% highlight Dockerfile %}
# base on latest ruby base image
FROM ruby:latest

# update and install dependencies
RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libpq-dev nodejs apt-utils

# setup app folders
RUN mkdir /myapp
WORKDIR /myapp

# copy over Gemfile and install bundle
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# copy over remaining app files
ADD . /myapp
{% endhighlight %}

This file specifies how Docker builds the container. It is based on the latest
Ruby base image and installs everything needed for the application to run,
including Ruby 2.2.0 and the required RubyGems.


## Installing Fig

Fig is a tool that allows you to specify, build and run services needed for your
application. Go [here](https://github.com/mfoemmel/fig) for
installation instructions.

When you have Fig installed, copy the following into a `fig.yml` file.

{% highlight yaml %}
db:
  image: postgres:9.3
  ports:
    - "5432"
web:
  build: .
  command: bundle exec rails server -p 3456
  volumes:
    - .:/app
  ports:
    - 3456:3456
  links:
    - db
{% endhighlight %}

With this in place you can now run `fig build` and let it build the containers
for the application and the database.

If you get a `No Rakefile found` error, make sure you are using Docker >1.3.0
(Thanks Wilker Lúcio).

## Making your app container friendly

Add the following to your `config/database.yml` file. This is needed as the web
container will need to communicate with the PostgreSQL container.

{% highlight yaml %}
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5
  username: postgres
  password:
  host: db
  timeout: 5000

test:
  <<: *default
  database: app_test

development:
  <<: *default
  database: app_development
{% endhighlight %}


## Booting the application on Docker

You're now ready to start setting up your app inside the container. Start by
bootstrapping the database with `fig run web rake db:setup`. Once this is done,
you can start the app via `fig up`.

You should now be able to access the app on http://localhost:3000.


## Running tests from Docker via Fig

You can now run your tests on the Docker container via `fig run web bundle exec
rspec` or whichever testing framework you use.


## Conclusion

I hope you found this useful and feel confident in trying out Docker for your
Rails applications. If you have any questions or feedback, please let me know in
the comments below.
