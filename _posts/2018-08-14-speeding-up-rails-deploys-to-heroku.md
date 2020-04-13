---
layout: post
title: Speeding up Rails deploys to Heroku
tags: rails heroku
---

Since adding Yarn and Webpacker to a fairly conventional Rails application, my
deploy times are taking up to 8 minutes to complete, with an average of roughly
7 minutes per deploy.

Here I am documenting some steps I took to reduce that down below 5 minutes.

## The setup

- Deploys are performed by SemaphoreCI once master is green.
- The Rails 5.2 application is running on professional dynos and using the
    official Ruby and NodeJS buildpacks.
- Migrations are run on each deploy using a release command (`release: bundle
    exec rake db:migrate`).

## Setting the correct Node and Yarn environments

`heroku config:set NPM_CONFIG_PRODUCTION=true YARN_PRODUCTION=true` ensures that
`devDependencies` are not installed
([source](https://devcenter.heroku.com/articles/nodejs-support#package-installation)).

## Disabling multiple Yarn installs

With multiple buildpacks, `yarn install` is run 3 times. Adding the following patch
to `Rakefile` ensures this is down to two
([source](https://github.com/heroku/heroku-buildpack-ruby/issues/654)).

```ruby
Rake::Task['yarn:install'].clear
task 'yarn:install' do
  puts 'Skipping yarn install from Rails'
end
```

## Reducing buildpacks to Ruby only

I'm not sure the NodeJS buildpack is entirely necessary anymore, but it does
come with some caching improvements (`node_modules` folder) that are not in the
Ruby buildpack.

## Conclusion

With the tweaks above in place, I managed to get deploy times down below 5
minutes. It's still not like the good old days of <1 minute deploys to Heroku,
but it's definitely an improvement.
