---
layout: post
title: Ruby on Rails on Caprover
---

Heroku changed their pricing, which made me move all my personal projects (Rails
applications) to Render.com. This worked well and I'd definitely recommend the service,
but having several small hobby apps there adds up as it's not free. This made me want a
server of my own, where I can easily deploy hobby apps to without hassle and increased
cost.

Looking around I found Caprover. It's gives you your own platform-as-a-service by running
a docker image. It comes with a nice web UI and CLI to go with it. There are loads of
plugins that enables easy setup of databases and the like. In short, it's a wrapper around
running docker containers and routing incoming requests to them.

The official docs are a great way to get started, so I wont get into that, but rather my
experience using it for hosting Rails applications.

## Background jobs

I did not find a nice solution to having a separate app instances for background job
workers, without having to deploy to each type (web, worker) separately.

## Stability

Somehow the caprover became unresponsive and I was not able to recover it. I probably
borked it somehow, but it did scare me off that I had no insight into how it was behaving
and to recover it.

## Lost connections to database containers

I'd often see errors in Sentry that the app could not connect to the database container.
This was intermittent and resolved itself, so I'm not sure what the cause was. It did not
give me confidence in hosting anything user-facing on caprover.

## Conclusion

In the end the issues above made me want to try something else and I settled on Dokku.
That has been great, and much closer to the heroku CLI experience. Setup was even easier
and it has been much more stable.
