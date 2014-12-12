---
layout: post
title: Profiling RSpec tests
---

Knowing _why_ something is slow is key to making it faster. Everybody hates slow
tests, so I'm sharing my approach to measuring why some RSpec tests were taking
ages to run.

<!-- more -->

The starting point was a model spec that took 22 seconds to run. My immediate
assumption was that the tests we are running slowly because they rely
heavily on interacting with the database (IO). At this point this is just a
theory and it will need to be proven before we take steps to remedy the
slowness. Cue profiling ruby code with
[Stackprof](https://github.com/tmm1/stackprof).

## Profiling RSpec 1.3 specs with Stackprof

I conjured up the following script to benchmark any RSpec (1.3) test with
Stackprof.

{% highlight ruby %}
ENV['RAILS_ENV'] = 'test'

require 'stackprof'
$:.unshift 'spec'
require 'spec/autorun'
require 'spec_helper'

interval = ENV.fetch('INTERVAL', 1000).to_i
limit = ENV.fetch('LIMIT', 20)
output_file = "tmp/#{ARGV[0].split('/').last}.dump"

StackProf.run(mode: :cpu, out: output_file, interval: interval) do
  ::Spec::Runner::CommandLine.run
end

system("stackprof #{output_file} --text --limit #{limit}")
{% endhighlight %}

You need to add `gem 'stackprof'` to your Gemfile in order for this to run. Save
it to a file and run it like this

{% highlight bash %}
bundle exec path/to/script <spec-file>
{% endhighlight %}

You can tweak the sampling interval by providing `INTERVAL=1000` and limit the
results output by providing a `LIMIT=20`.

The output looks something like this:

{% highlight bash %}
==================================
  Mode: cpu(1000)
  Samples: 32177 (6.74% miss rate)
  GC: 13931 (43.29%)
==================================
TOTAL    (pct) SAMPLES    (pct) FRAME
 3545  (11.0%)    3545  (11.0%) ActiveRecord::ConnectionAdapters::Mysql2Adapter#query
14202  (44.1%)    3358  (10.4%) ActiveSupport::Dependencies::Loadable#require
 1653   (5.1%)    1641   (5.1%) block in ActiveSupport::BufferedLogger#flush
  794   (2.5%)     515   (1.6%) ActiveSupport::Callbacks::Callback#should_run_callback?
  497   (1.5%)     307   (1.0%) ActiveSupport::Memoizable::InstanceMethods#prime_cache
 1207   (3.8%)     300   (0.9%) block in ActiveSupport::Dependencies::Loadable#require
  399   (1.2%)     263   (0.8%) GetText::PoParser#parse
  249   (0.8%)     249   (0.8%) block in ActiveSupport::Dependencies#search_for_file
 2208   (6.9%)     108   (0.3%) ActiveRecord::ConnectionAdapters::Mysql2Adapter#select
  ...
{% endhighlight %}

The results above list the percentage spent in various methods whilst running
the spec. From this it is clear that the biggest timesink whilst running the
spec was `ActiveRecord` querying the database. Having this knowledge enabled me
to start looking into how to reduce the problem, and also to have a concrete
number to benchmark to see whether I'm making any progress.

Another offender that I hadn't suspected was `ActiveSupport::BufferedLogger`
writing the teste log to a file. This was easily reduced by adding
`config.log_level = :error` to `config/environments/test.rb`.

## Profiling RSpec 3 specs with Stackprof

I've ported the script to work with RSpec 3 as that will benefit the
majority of setups out there.

{% highlight ruby%}
#!/usr/bin/env ruby

require 'stackprof'
$:.unshift 'spec'
require 'rails_helper'

spec = ARGV[0]
interval = ENV.fetch('INTERVAL', 1000).to_i
limit = ENV.fetch('LIMIT', 20)
output_file = "tmp/#{spec.split('/').last}.dump"

StackProf.run(mode: :cpu, out: output_file, interval: interval) do
  RSpec::Core::Runner.run([spec], $stderr, $stdout)
end

system("stackprof #{output_file} --text --limit #{limit}")
{% endhighlight %}

## Conclusion

You cannot optimise what you can't measure. Some tools are a bit arcane, but a
bit of digging can quickly lead to tangible results that can then be improved
upon.
