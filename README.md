# Fitgem [![Build Status](https://secure.travis-ci.org/whazzmaster/fitgem.png)](http://travis-ci.org/whazzmaster/fitgem)

Provides access to fitbit.com data through their OAuth/REST API.  Fitgem can pull data with or without user
authentication. Without user authentication, any data that the a fitbit.com user has denoted as 'public' can be
gathered.  If a user logs in via OAuth then all exposed data can be gathered.

The [Fitbit API](https://wiki.fitbit.com/display/API/Fitbit+API) is currently in BETA and is under
development to extend its reach.  Since it is early in the lifecycle of the API I expect this gem to go through a number
of revisions as we attempt to match the functionality of their platform.

# Usage

Install fitgem:
```
$ gem install fitgem
```

Comprehensive method documentation is [available online](http://www.rubydoc.info/github/whazzmaster/fitgem/frames).

[The wiki has information](https://github.com/whazzmaster/fitgem/wiki/The-OAuth-Process) on how to use fitgem in the
OAuth handshake with [fitbit.com](http://www.fitbit.com). You may also be interested in using
[omniauth-fitbit](https://github.com/tkgospodinov/omniauth-fitbit) to integrate Fitbit accounts into your web
application.

## Usage in a Rails Application

We've started to develop an example app using the fitgem client.
See [https://github.com/whazzmaster/fitgem-client](https://github.com/whazzmaster/fitgem-client) for more information or
check out [the hosted version](http://www.fitbitclient.com). The fitgem-client project is evolving more slowly than the
library itself, but work continues.

# Subscriptions

The Fitbit API allows for you to set up notification subscription so that when values change (via automatic syncs with
the fitbit device) your applications can be notified automatically.  You can set up a default subscription callback URL
via the [Fitbit dev site](https://dev.fitbit.com/ 'Fitbit Developer Site') and then use the Subscriptions API to add or
remove subscriptions for individual users.

__Currently, notification management is experimental in this gem__.  There is currently code to add, remove, and list
subscriptions (foods, activities, sleep, body, and all collections).

# Contributing to fitgem #

The Fitbit REST API is in BETA right now, and so it will quite likely change over time (though I can't be sure whether
it will be additive change or change of the non-backwards-compatible variety).  I aim to keep as up-to-date as I can but
if you absolutely need functionality that isn't included here, feel free to fork and implement it, then send me a pull
request.

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise
necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Contributors

Many thanks to everyone that has contributed to improve fitgem!

[https://github.com/whazzmaster/fitgem/graphs/contributors](https://github.com/whazzmaster/fitgem/graphs/contributors)

# Copyright & Disclaimer

Copyright (c) 2011-2012 Zachery Moneypenny. See LICENSE for further details. __I am not employed by fitbit.com__.  I
created this library to assist other ruby developers in creating interesting applications on top of fitbit.com's
data store and device data stream.

