---
layout: post
title: "Metrics driven development"
date: 2012-03-10 13:14
comments: true
categories: metrics
url: /2012/metrics-driven-development
---

The statement "If you can't measure it, you can't optimize it" really sits well
with me. I my short spanned working career I have already
spent time on code which did not result in any added business value. One example
of doing this was a large refactoring on the persistence layer of an app.
Although this cleaned up the code, it did not change anything seen from a
business perspective. E.g. not measurably driving the business forward.
[This talk](http://pivotallabs.com/talks/139-metrics-metrics-everywhere)
by Coda Hale made me realize that if a feature/change doesn't add any business value, then
there is absolutely no reason for spending time (and your employers money) on
it.

<!-- more -->

There exists loads of tools that can help measure metrics of an application, and
in doing that, you can easily justify or reject a feature or change. A great
service for measuring metrics is [Instrumental](https://instrumentalapp.com/).
Basically you pay for not having to fiddle around setting up a metrics solution,
and can therefore start measuring your app immediately.

In short: If you can measure the effect of a change/feature, you are guessing on
the effect it will have on you business, and most likely shouldn't be working on
it.
