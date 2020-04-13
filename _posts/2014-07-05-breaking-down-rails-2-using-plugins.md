---
layout: post
title: Breaking down Rails 2 using plugins
tags: rails
---

Going SOA is no easy feat, and as usual when something is complex and
daunting, the best course of action is to break down the problem and take it one
step at a time. With a big application, a good first step would be to
separate the application into it's apparent domain concepts.

<!-- more -->

If you, like many other successful startups, have a large monolithic Rails 2
application and want to break it down into multiple more manageable parts,
using plugins might be a way forward.

I will use an admin area to illustrate my point, but this process can be applied
to any area of an application.

## Rails plugins to the rescue

Rails 2 comes with support for putting application logic into plugins. This
concept was evolved and extended into engines in Rails 3. A plugin can contain
routes, controllers, models, rubygems and tests, so they act as self-contained
applications.

By moving the admin area into a plugin, it becomes cleanly separated from the
rest of the application and it can be worked on and tested in isolation. It
could even eventually be moved outside the application.

The following describes the various aspects of moving domain logic into a
plugin.

## Using an alternative plugin folder

The default location for plugins in Rails 2 is `vendor/plugins`, but given this
is not vendor logic, we'd like to put it elsewhere. We've decided on adding a
`services` folder to contain extracted plugins. You can tell Rails to look here
for plugins by adding this to your `config/environment.rb:

{% highlight ruby %}
Rails::Initializer.run do |config|
  config.plugin_paths << 'services'
end
{% endhighlight %}

## Bootstrapping a plugin

You can scaffold a new plugin via `script/generate plugin <name>` and move the
created folder (`vendor/plugins/<name>`) into the `services` folder.

The scaffold creates the appropriate hook files you need to integrate the
plugin with the main application. This includes hooks into how the plugin is
installed and removed, which you propbably don't need. A file named `init.rb` is
also created, and this is where you add any initialization the plugin might need
when the main application is booted.


## Directory structure

Below is an example of how a plugin can be structured.

    ▾ services/
      ▾ admin/
        ▾ app/
          ▸ controllers/
          ▸ helpers/
          ▸ mailers/
          ▸ models/
          ▸ views/
        ▸ config/
        ▸ lib/
          init.rb
          Rakefile
          README

Rails will automatically add `app/controllers`, `app/models`, `app/views` and
`config` to the load path. If you wish to add other folders like `app/mailers`
and `app/helpers`, this can be done by adding the following to `init.rb`:

{% highlight ruby %}
# add plugin folders to ruby and rails load-paths
%w{ helpers mailers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
end

# include helpers so they are accessible in views
ActionView::Base.class_eval do
  include Admin::Helper
end
{% endhighlight %}


## Routes

Routes can easily be extracted to a plugin by adding a `routes.rb` in the
`config` folder:

{% highlight ruby %}
ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :permissions
  end
end
{% endhighlight %}


## Mailers

Rails 2 doesn't support mailers in plugins out of the box, but you can easily
make it work by setting the `template_root` in your extracted mailers:

{% highlight ruby %}
# file located in: services/admin/app/mailers/admin/mailer.rb
module Admin
  class Mailer < ActionMailer::Base

    self.template_root = "#{RAILS_ROOT}/services/admin/app/views"

    def admin_welcome_message
      # ...
    end
  end
end
{% endhighlight %}

This will allow you to put you mailer views in
`services/admin/app/views/admin/mailer`.

## Are plugins future proof?

If you're moving towards Rails 3/4, then going with a plugin-based solution
might seem like going backwards. Plugins can easily be changed to work with both
Rails 3 and 4. One method of doing that is covered
[here](http://matt.coneybeare.me/how-to-convert-simple-rails-23-style-plugins/).

Another solution is to reorganise the plugin into a Rails engine structure and
make it work more like a full-fledged Rails app on it's own.


## Conclusion

While Rails 2 plugins are not as neat and full-featured as Engines in Rails 3,
they can be used to break down a large application into separate parts. The
extraction is pretty straightforward and leaves you with a common place for
domain logic, as opposed to having to search through the `app` folder.

Splitting your test suite is another neat benefit and can save development and
testing time by only needing to run the tests relevant for your changes.

If you hit any issues with this approach, please do get in touch. Go forth and
refactor!

### References

[http://guides.rubyonrails.org/v2.3.11/plugins.html](http://guides.rubyonrails.org/v2.3.11/plugins.html)

[http://railscasts.com/episodes/149-rails-engines](http://railscasts.com/episodes/149-rails-engines)

[https://www.mikeperham.com/2009/04/18/engines-in-rails-23/](https://www.mikeperham.com/2009/04/18/engines-in-rails-23/)
