---
layout: post
title: Rails with PostgreSQL on Docker using Fig
---

Docker is a platform for building, shipping and running all sorts of
applications [(source)](https://www.docker.com/whatisdocker/). It's a very
powerful and extensible alternative to other forms of virtualization and
platforms like Heroku. This post described the steps I've taken to get an
existing Rails app onto Docker using Fig.

<!-- more -->


## Installing Docker

There are many guides on installing Docker. I recommend starting
[here](https://docs.docker.com/installation/#installation), or if you are on
OSX, start [here](https://github.com/noplay/docker-osx#docker-osx). The rest of
this guide assumes you have Docker setup and running locally.


## Ruby 2.1.2 Dockerfile

Copy the following into a `Dockerfile` and run `docker build .` to start
building the container. Once successful, try running the same command to see
that Docker properly caches the build so it is done in seconds.

{% highlight Dockerfile %}
# Base off the latest ubuntu release
FROM ubuntu:14.04

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev wget git zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev nodejs

# install Ruby
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
ENV PATH /.rbenv/bin:/.rbenv/shims:$PATH
RUN echo PATH=$PATH
RUN rbenv init -
RUN rbenv install 2.1.2 && rbenv global 2.1.2

# Never install rubygem docs
RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

# Install bundler
RUN gem install bundler && rbenv rehash

# Add gemfiles early to cache installed gems
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

# Install app rubygem dependencies
RUN bundle install

# Change and link to the app directory
RUN mkdir /app
WORKDIR /app
ADD . /app
{% endhighlight %}

This file specifies how Docker builds the container. It is based on the latest
Ubuntu (14.04) and installs everything needed for the application to run,
including Ruby 2.1.2 and the required RubyGems.


## Installing Fig

Fig is a tool that allows you to specify, build and run services needed for your
application. Go [here](http://www.fig.sh/install.html) for
installation instructions.

When you have Fig installed, copy the following into a `fig.yml` file.

{% highlight yaml %}
db:
  image: orchardup/postgresql
  ports:
    - 5432
web:
  build: .
  command: bundle exec rails server -p 3000
  volumes:
    - .:/app
  ports:
    - 3000:3000
  links:
    - db
{% endhighlight %}

With this in place you can now run `fig build` and let it build the containers
for the application and the database.

## Making your app container friendly

Add the following to your `config/database.yml` file. This is needed as the web
container will need to communicate with the PostgreSQL container.

{% highlight yaml %}
development:
  host: <%= ENV.fetch('DB_1_PORT_5432_TCP_ADDR', 'localhost') %>
  port: <%= ENV.fetch('DB_1_PORT_5432_TCP_PORT', '5432') %>
  username: docker
  password: docker
  ...
{% endhighlight %}

## Booting the application on Docker

You're now ready to start setting up your app inside the container. Start by
bootstrapping the database with `fig run web rake db:setup`. Once this is done,
you can start the app via `fig up`.

You should now be able to access the app on http://localhost:3000 (or
http://localdocker:3000 if you're using docker-osx).


## Running tests from Docker via Fig

You can now run your tests on the Docker container via `fig run web bundle exec
rspec` or whichever testing framework you use.

## Conclusion

I hope you found this useful and feel confident in trying out Docker for your
Rails applications. If you have any questions or feedback, please let me know in
the comments below.

