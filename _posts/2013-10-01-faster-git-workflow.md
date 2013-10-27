---
layout: post
title: Faster Git workflows
---

Over the last decade, Git has fast become an integral part of most developers
daily routine. Fork this and merge that, you know the drill. There are many
strategies for using Git to develop software, and at HouseTrip we follow a simple
feature-branch model. All new changes are committed in separate feature
branches, and then pull-requested to be merged into master, or an integration
branch for larger features. This workflow works very well, and that is in large
part due to the awesomeness of GitHub.

<!-- more -->

To avoid name clashes and to better be able to identify branches, we follow a
branch naming strategy along the lines of `team-name/feature-name-story-id`.
This can often result in a lot of typing when changing branches.

I usually work on multiple features at a time, some awaiting sign-off, others
needing review etc. Therefore I usually have somewhere around 10 branches
checked out locally, and being able to switch between them fast allows me to
work faster.

## Alias commonly used branches

One simple trick I use is to add to alias integration and staging branches for
easier access when running Git commands. E.g. I have the following in my `.zshrc`


{% highlight bash %}
echo INT=my-team/integration/sweet-new-feature
{% endhighlight %}

This allows me to quickly interface with the integration branch in the vein of:

{% highlight bash %}
git diff $INT
git merge $INT
git pull-request -t $INT
{% endhighlight %}

This very simple trick has saved me a lot of typing. I know, and use, git branch
completion with ZSH, but given our large team and number of branches, it is way
too slow when I want to move fast. I sounds a bit anal, but waiting seconds
before switching a branch is really annoying.

## Useful Git aliases

Git aliases is another great way to speed up your day to day work. I won't bore
you with [all my aliases](https://github.com/thejspr/dotfiles/blob/master/gitconfig),
but rather explain the ones I use the most. The following aliases goes into your
`~/.gitconfig` under the `[alias]` group.

### Enhanced git log

{% highlight bash %}
l = log --graph \
        --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr) %C(black)<%an>%Creset' \
        --abbrev-commit \
        --date=relative -14
{% endhighlight %}

This alias produces a slimmed down and decorated version of the git log:

![Enhanced Git log](/img/git-log.png)

### Commit all changed files

{% highlight bash %}
ca = !git add -A && git commit -v
{% endhighlight %}

This is one of my most used commands. It adds all changed files and opens my
editor (Vim) showing the diff. This allows me to quickly scan the changes, write
a commit message and save, hereby committing the changes.

### Fast git status

{% highlight bash %}
g() {
  if [[ $# == '0' ]]; then
    command git status -sb
  else
    command git "$@";
  fi
}
{% endhighlight %}

This bash function prints the git status when no arguments are supplied,
otherwise it runs the git command as usual.

![Git status alias](/img/git-status.png)

I hope these tips can help in your day-to-day work and speed up your git usage.
Thanks for stopping by. To keep updated with new posts, add my [RSS feed](/feed.xml)
to your reader of choice.
