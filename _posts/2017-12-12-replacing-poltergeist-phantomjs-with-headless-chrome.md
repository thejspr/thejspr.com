---
layout: post
title: Replacing Poltergeist/PhantomJS with Headless Chrome
tags: rails testing
---

The Chrome browser supports a headless mode as of version 59, which is a
god-send when you do automated testing because it can bring your testing
environment closer to the real-deal.

Having used PhantomJS via Poltergeist in my Rails apps for a while, I wanted to
take a stab at moving to Chrome because I saw PhantomJS related failures when
upgrading from React 15.x to 16.2 (`ReferenceError: Can't find variable: Map`).

## Installation

Thoughtbot have an [excellent
post](https://robots.thoughtbot.com/headless-feature-specs-with-chrome) on getting set up,
so I want duplicate it here. I'd rather focus on the issues I had and how I
solved them.

## Fails in headless, but otherwise passes

Not entirely sure why this fixed it, but setting a `window-size` solved this
pesky failure for me.

``` ruby
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu window-size=1280,1000] }
  )
```

I think was caused by an element not being visible.

## Debugging

A cool benefit of using Chrome for testing is that by removing `headless` from
the `chromeOptions`, a visible browser is booted and I can see whats going on.
If you want to stop at a certain point, add this line in your spec:

``` ruby
page.execute_script('debugger')
```

For this to work you need to be swift at opening the dev tools in the browser
booted by the test. Slightly annoying if you miss it, but it's really cool to be
able to drop into a debugger in my tests.

## `trigger` not supported

Easy fix is replacing something like `find('selector').trigger('click')` with
`find('selector').click`.

## Conclusion

My tests now feel faster and I'm more confident that the test environment is a
closer match to my customers. The debugging trick is also neat, and I hope they
add a CLI option to open chrome with dev-tools already open.
