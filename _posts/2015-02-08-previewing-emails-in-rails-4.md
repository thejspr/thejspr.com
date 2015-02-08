---
layout: post
title: Previewing emails in Rails 4
published: true
---

Rails 4.1 introduced a new feature which allows you to preview emails via your
browser. This functionality was initially developed by 37Signals as
[Mail View](https://github.com/basecamp/mail_view), and later built into into Rails.

Start by figuring out where to put your preview classes, as this is depending on
your test framework.  `ActionMailer::Base.preview_path` will tell you where
Rails will look. This is `spec/mailers/previews` if you are using RSpec and
`test/mailers/previews` if you are using Rails' built in testing framework. You
can change the default via `config.action_mailer.preview_path`.

## Previewing emails

You can now create a preview class in your preview path to load any dependencies
the mails may have. An example for a `Notifier` mailer would be:

{% highlight ruby %}
# spec/mailers/preview/notifier_preview.rb

class NotifierPreview < ActionMailer::Preview
  def welcome
    Notifier.welcome(User.last)
  end
end
{% endhighlight %}

The method should return a `Mail::Message` object with all the required data
needed. In the example above, the last create user is provided to have some sane
default data when previewing the mail. You can also use fixtures or create
random models, anything goes.

With the preview class in place, you can not go to `/rails/mailers` where you
should have a link to the email preview (if nothing shows up, try restarting the
webserver).

That's it. Now there is not excuse not to close your email client when working
on your Rails apps.

## Conclusion

I think this functionality is quite neat, and useful for designing and testing
emails within the development workflow. Although this will get you most of the
way, it's still a good idea to test how the emails looks in various email
clients. [Litmus](https://litmus.com/email-testing) is a great tool that makes
this task easier.
