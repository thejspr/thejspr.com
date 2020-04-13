---
layout: post
title: "Ignore specific requests with VCR"
date: 2012-06-18 16:42
tags: testing rails
url: /2012/ignore-specific-requests-with-vcr
---

I recently needed to test the integration between two Rails apps running locally on
my machine and wanted to record the HTTP interactions with
[VCR](https://github.com/myronmarston/vcr). VCR enables you to mock HTTP requests by
recording interactions and later replay them when you run your tests. This is useful
when dealing with third-party API's and if your application is interacting with other
applications you don't want to depend on when running your tests.

<!-- more -->

VCR has an option which disables it from mocking any requests to localhost. As I
turned this option off, another problem arose; it wouldn't allow selenium-webdriver to
connect to `http://127.0.0.1/_IDENTITY_` (why it needs this I do not know). In
searching for an answer I came upon this neat, and seemingly undocumented, feature of
VCR: Ignoring requests to specific hostnames.

{% highlight ruby %}
c.ignore_request do |request|
  URI(request.uri).host == '127.0.0.1'
end
{% endhighlight %}

Another use-case could be to ignore all requests to Facebook:

{% highlight ruby %}
c.ignore_request do |request|
  URI(request.uri).host =~ %r{.*facebook\.com/.*}
end
{% endhighlight %}

The feature was enabled in [this
commit](https://github.com/myronmarston/vcr/commit/531896caaf094a298baf8a62e490eeda0d31ee15),
as a response to [this issue](https://github.com/myronmarston/vcr/issues/42). So
to enable this feature you need version 2 or greater of VCR.
