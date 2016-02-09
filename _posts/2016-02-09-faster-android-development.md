---
layout: post
title: Faster Android Development
---

In November 2015 I moved from Ruby on Rails to Android in my daily work at
[GoMore](https://gomore.com), and since then I've discovered several tips to improve my development
speed. Behold, try the following to get a faster Android development workflow.

## Use the Genymotion emulator

Using Genymotion instead of a stock emulator or physical devise has been the
most effective in speeding up my workflow. The emulator is a lot faster at
booting, installing and running apk than the alternatives. Genymotion is free
for personal use, and you can get it [here](https://www.genymotion.com/).

If your app rely on Google services, [follow
this guide](https://gist.github.com/wbroek/9321145) to manually install it.

## Get a big screen

For the first month I worked solely on my 13" laptop and was semi-happy with it.
Then I got a massive [LG 34" UltraWide](http://www.lg.com/uk/monitors/lg-34UM95)
monitor and the difference is amazing! Having Android studio, a browser, Slack
and an emulator on the screen without overlap and having to <ctrl-tab> is
wonderful! Below is a picture of my current standing-desk setup, SO MUCH ROOM
FOR ACTIVITIES!

![Standing desk setup](/img/lg_standing.png)

## Unit Testing

Building the app every time I needed to check a change is tiresome, and this is
where unit tests come in handy. They run in no-time and will allow you to keep
in the zone without having to switch between device and editor all the time. If
you have not yet embraced TDD, I highly recommend you try it out.

You can also do some functional testing without having to build and install your
APK, try [Robolectric](http://robolectric.org/) which mocks out device APIs
allowing you to run "headless" functional tests on the JVM.

## Speeding up the build

Unit testing will not be enough to verify your feature works, so you will be
building you app many times per day you work on it. Having a slow build will
cause you to loose focus and waste time waiting for it to compile and install. I
recently found [this Gradle
plugin](https://github.com/passy/build-time-tracker-plugin) which makes it
easier to find hotspots in your build.

## Conclusion

I'm only getting my toes wet in this Android stuff and it's amaizng what's out
there in terms of resources and tools to improve your workflow. Get in touch if
you have anything neat I need to check out.

### More Android resources

[Codelabs - Lots of tutorials from Google](https://codelabs.developers.google.com/)

[Caster.io - Android screencasts](https://caster.io/)
