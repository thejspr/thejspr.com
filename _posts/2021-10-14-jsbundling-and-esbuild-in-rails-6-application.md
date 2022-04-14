---
layout: post
title: JSbundling and esbuild in Rails 6 application
---

1. Add jsbundling-rails to your Gemfile with `gem 'jsbundling-rails'`
2. Run ./bin/bundle install
3. Run ./bin/rails javascript:install:esbuild
4. Start your dev server with `foreman start -f Procfile.dev`, or run `rails s`
   and `yarn build --watch` separately.
5. Make it work :) It's highly dependent on your setup, whether you are using
   webpack etc. Mostly it should be fairly straightforward.
6. If you are using a separate yarn install on github actions, remove it as it's
   now taken care of by rails.
7. Ensure you have yarn/node available if you are on Heroku:
`heroku buildpacks:add --index 1 heroku/nodejs`
8. Deploy
