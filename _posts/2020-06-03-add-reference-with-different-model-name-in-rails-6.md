---
layout: post
title: Adding reference with different model name in Rails 6
tags: rails
---

If you need to add a reference on a model and the reference
is named different from the model, do the following:

``` bash
rails generate migration Add<Reference Name>To<Target Model> <Reference name>:references

e.g.

rails generate migration AddCreatorToOrders creator:references
```

Then edit the created migration to be the following:

``` ruby
class AddCreatorToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :creator, foreign_key: { to_table: :users }
  end
end
```

The important bit here is changing `foreign_key: true` to
`foreign_key: { to_table: :users }`.

Finally you also need to specify the relationship correctly on the model:

``` ruby
belongs_to :creator, class_name: 'User'
```

Done and dusted.
