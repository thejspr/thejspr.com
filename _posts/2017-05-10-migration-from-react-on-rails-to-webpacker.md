---
layout: post
title: Migrating from React-on-rails to Webpacker
---

Having just migrated from ReactOnRails to Webpacker for handling the frontend
code in my Rails app, I thought I'd share the steps I took. I switched because I
was tired of having react on rails in both the Gemfile and client code,
maintaining the same version in both and because Webpacker was supported by
Rails in 5.1.

## Migration steps

1. Install Webpacker gem and run `rails webpacker:install` and `rails webpacker:install:react`.
2. Run `webpack` to verify it works
3. Merge packages and configurations from `client/package.json` to `package.json` and `yarn install`.
4. Move client into `app/javascripts` via `cp -R client/app app/javascript`.
5. Create corresponding entry files in `app/javascript/packs`.
6. Rendering React components is now a little bit trickier without the helpers
   from ReactOnRails, but below is how I did it.

``` ruby
  # in your template do something like this
  <%= react_component('cloud', { files: some_files }) %>
```

``` ruby
  # application_helper.rb
  def react_component(pack, props)
    content = javascript_pack_tag(pack.downcase)
    content << content_tag(:div, nil, { id: 'container', data: props })
    content.html_safe
  end
```

``` javascript
  // app/javascript/packs/cloud.js
  import Component from '../cloud/cloud';
  import ComponentRenderer from '../component-renderer';

  ComponentRenderer(Component);
```

``` javascript
  // component-renderer.js
  import React from 'react';
  import { render } from 'react-dom';

  export default function ComponentRenderer(Component) {
    document.addEventListener('DOMContentLoaded', () => {
      const container = $('#container');
      const myProps = container.data();
      render(<Component {...myProps} />, container.get(0));
    });
  }
```

## Testing

Run `RAILS_ENV=test webpack` to build assets before running specs that need them, I used this
[neat solution](https://gist.github.com/naps62/a7dcce679a45592714ea6477108f0419).

## Conclusion

Overall the switch took a few days, but I think it's worth it as I now have a
neat setup with `webpack-dev-server` and stylesheets in webpack, something I
didn't get when first setting up ReactOnRails about a year ago. But the biggest
win here is moving away from the magic of ReactOnRails to something where I've
gained a much better understanding of all the moving parts, and I'm not better
positioned to deal with any issues going forward. That being said, I'd like to
thank the creators and maintainers of ReactOnRails for making it easy to get
started using React with Rails.
