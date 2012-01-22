# Fitgem [![Build Status](https://secure.travis-ci.org/whazzmaster/fitgem.png)](http://travis-ci.org/whazzmaster/fitgem)

Provides access to fitbit.com data through their OAuth/REST API.  Fitgem can pull data with or without user authentication. Without user authentication, any data that the a fitbit.com user has denoted as 'public' can be gathered.  If a user logs in via OAuth then all exposed data can be gathered.

The fitbit.com API is currently (Early 2012) in BETA and is under development to extend its reach.  Since it is early in the lifecycle of the API I expect this gem to go through a number of revisions as we attempt to match the functionality of their platform.

# Usage #

Install fitgem:
```
$ gem install fitgem
```

[The wiki has information](https://github.com/whazzmaster/fitgem/wiki/The-OAuth-Process) on how to use fitgem in the OAuth handshake with [fitbit.com](http://www.fitbit.com)

## Usage in a Rails Application ##

We've started to develop an example app using the fitgem client.  See [https://github.com/whazzmaster/fitgem-client](https://github.com/whazzmaster/fitgem-client) for more information or check out [the hosted version](http://www.fitbitclient.com). The fitgem-client project is evolving more slowly than the library itself, but work continues.

# Subscriptions #

The Fitbit API allows for you to set up notification subscription so that when values change (via automatic syncs with the fitbit device) your applications can be notified automatically.  You can set up a default subscription callback URL via the [Fitbit dev site](https://dev.fitbit.com/ 'Fitbit Developer Site') and then use the Subscriptions API to add or remove subscriptions for individual users.

__Currently, notification management is experimental in this gem__.  There is currently code to add, remove, and list subscriptions (foods, activities, sleep, body, and all collections).


# FAQs
## What About ruby-fitbit?

There is a good looking gem called [ruby-fitbit](https://github.com/danmayer/ruby-fitbit "ruby-fitbit") that also aims to collect data from the site.  It was created before they released their REST API and uses screen-scraping to gather the data rather than through their API.  I looked into forking it and refactoring to use the new API but after looking through the code I felt it would be more of a total rewrite and so decided to create a new gem that I could design from scratch.

## Why the Name Change?

It turns out that Fitbit.com does not want people to create libraries or applications that incorporate the name 'fitbit'.  So, on May 12th, 2011 I changed the name of the project/gem from 'fitbit' to 'fitgem'.

# Notice

To be clear: __I am not employed by fitbit.com__.  I created this library to assist other ruby developers in creating interesting applications on top of fitbit.com's data store and device data stream.

# Contributing to fitgem #

The Fitbit REST API is in BETA right now, and so it will quite likely change over time (though I can't be sure whether it will be additive change or change of the non-backwards-compatible variety).  I aim to keep as up-to-date as I can but if you absolutely need functionality that isn't included here, feel free to fork and implement it, then send me a pull request.

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright ###

Copyright (c) 2011-2012 Zachery Moneypenny. See LICENSE for further details.
