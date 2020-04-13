---
layout: post
title: "Show Rails environment in Pry"
date: 2012-10-31 23:59
tags: rails
url: /2012/display-rails-environment-in-pry
---

I believe that environment awareness is important. Especially when it comes to
your Rails environment and mocking around in a production setting. Hence, I
added the following lines to my Pry config (.pryrc) to have the prompt include the
current environment.

<!-- more -->

{% highlight ruby %}
if defined?(Rails)
  Pry.config.prompt = [proc { env }, "     | "]
end

def env
  Rails.env.production? ? "\e[1;31m#{Rails.env}\e[0m > " : "#{Rails.env} > "
end
{% endhighlight %}
