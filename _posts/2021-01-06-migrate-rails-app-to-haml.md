---
layout: post
title: Migrate Rails app to Haml
---

For years I've been using ERB as my templating language of choice. Before that I
tried Slim and Haml, but ended back on ERB for performance reasons. Since then
Haml performance has improved, and I'm now moving back to it so save myself some
typing. These are the steps I took:

1. `bundle add haml-rails`
2. `rails generate haml:application_layout convert`
3. run tests to check everything is working.
4. `rm app/views/layouts/application.html.erb`
5. `rails haml:erb2haml`
6. run tests to check everything is working.
7. commit

That's it.
