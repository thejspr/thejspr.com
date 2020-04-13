---
layout: post
title: Running only failing tests with RSpec
tags: rails testing
---

A common pattern in TDD is to make changes, run the suite, fix any failing tests
and finally run the suite again to ensure everything is green.

A newt way to speed up this flow is by using the `--only-failures` flag with
RSpec which only runs the recent failing tests.

For this to work you need to add the following to your `spec_helper.rb`:

``` ruby
RSpec.configure do |c|
  c.example_status_persistence_file_path = "tmp/examples.txt"
end
```

Now you can run the recent failures via `rspec --only-failures`.

You can even pick them off one at a time with `rspec --next-failure`.
