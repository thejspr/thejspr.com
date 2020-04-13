---
layout: post
title: "Radical Feature Justification"
date: 2012-05-24 02:43
tags: process
url: /2012/radical-feature-justification
---

Reading Eric Ries' *The lean Startup* has recently got me thinking about how best
to avoid wasting time developing the wrong things. Spending time developing a
feature is always in vain if no one uses it, no matter how sound the idea and
implementation might be.

<!-- more -->

There are many solutions for determining whether a feature should be added to a
product or not. Methods like user surveys and questionnaires are proven to work,
but adds another level of abstraction to the scenario. Whether a user thinks
he/she needs (and would use) a given feature is different to actually using it.

So instead of asking whether a user would use a given feature, another method
would be to just add the actionable object (link, button, etc.) to the product
and register whenever a user tries to use it?

Given it is clear what the actionable object does, this method of feature
justification moves the focus from something users *might* need, to them actually
trying to use it.

Whenever a user would try to use the fake feature, the event should be
registered and a helpful message should be displayed. The message could go
something like this:

![radical feature justification](/img/radical_feature_justification.png)

Being constantly reminded that a feature is unavailable is annoying, therefore
the actionable object should only be visible until the user has interacted with
it.

When enough users have tried to use the proposed feature, it is more likely that
it's development has been justified. When the feature is then added, it would be
great if users who tried to use it before are shown a message on first use,
thanking them for their patience and feedback.

*Note: This theory is yet to be testing in the wild, so don't blame me if you end
up angering your customers.*
