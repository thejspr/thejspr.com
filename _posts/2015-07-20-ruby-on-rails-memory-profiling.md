---
layout: post
title: Ruby on Rails Memory Profiling
---

Adding a new gem to the Gemfile is a good way to get a feature live sooner, but
it also comes with a cost. A big cost is maintenance, which I won't get into
with this post. Another big one is the resource requirements this new gem suddenly
adds to your application. Without tracking this, you can easily end up with an
app that takes up several hundred MB memory in object allocation.

In order to stay on top of this we have the excellent [memory_profiler](https://rubygems.org/gems/memory_profiler)
gem. It allows you to fairly easily inspect which gems or files allocate the
most memory when you boot your application. Once installed `gem install
memory_profiler`, you can run the following script in your Rails app to get a
detailed report over memory usage.

{% highlight ruby %}
require 'memory_profiler'

report = MemoryProfiler.report do
  require_relative '../config/environment'
  # Add specific code here if you want to profile deeper
end

report.pretty_print
{% endhighlight %}

Run and store the output for easier inspection in your editor
`ruby memory-profiler.rb > output.txt`.

This will give you a lot of information on how much memory is being used, which
gems are responsible and even the lines on which the objects are being
allocated.


This will give you a lot of information on how much memory is being used, which
gems are responsible and even the lines on which the objects are being
allocated.

## Only require necessary gems

This process made me notice that I was requiring `rubocop` even though it was
only rarely used. Changing it to `gem 'rubocop', require: false` in the `Gemfile`
sorted it right out.

{% highlight text %}
Before:
Total allocated: 196866115 bytes (1543730 objects)
Total retained:  61546346 bytes (259608 objects)

After:
total allocated: 172762095 bytes (1343193 objects)
total retained:  54188357 bytes (246362 objects)

Difference:
Less allocated 24104020 bytes ~ 24MB
Less retained 7357989 bytes ~ 7MB
{% endhighlight %}

## Conclusion

I implore you to try this out on your Rails application, you might be surprised by
what you find. I also warmly recommend this talk by Sam Saffron
[RedDotRuby 2015 - Keynote: Off the Rails by Sam Saffron](https://www.youtube.com/watch?v=aP5NNkzb4og).
