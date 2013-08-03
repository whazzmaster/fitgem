# Fitgem [![Build Status](https://secure.travis-ci.org/whazzmaster/fitgem.png)](http://travis-ci.org/whazzmaster/fitgem)

Provides access to [fitbit.com](http://www.fitbit.com) data through [their REST API](http://dev.fitbit.com).  Fitgem can pull data with or without user authentication. Without user authentication, any data that the a fitbit.com user has denoted as 'public' can be gathered.  If a user logs in via OAuth then all exposed data can be gathered.

The [Fitbit API](https://wiki.fitbit.com/display/API/Fitbit+API) is currently in BETA and is under development to extend its reach. As the API evolves and is enhanced it's a priority to mirror the functionality in the gem, and any **pull requests** are appreciated if you see gaps in API support.

# Usage

Install fitgem

```bash
$ gem install fitgem
```

or add it to your Gemfile

```ruby
gem 'fitgem'
```

Comprehensive method documentation is [available online](http://www.rubydoc.info/github/whazzmaster/fitgem/frames).

The best way to connect your users to the Fitbit API is to use
**[omniauth-fitbit](https://github.com/tkgospodinov/omniauth-fitbit)** to integrate Fitbit accounts into your web
application. Once you have a Fitbit API OAuth `access_token` for a user it's simple to create a client object through fitgem to send and receive fitness data.

## Reference Application

To learn more about how to use fitgem in a Rails application, go to [http://fitbitclient.com](http://fitbitclient.com) or see the code at [https://github.com/whazzmaster/fitgem-client](https://github.com/whazzmaster/fitgem-client).

The reference app is written using Rails 3.2 and [Backbone.js](http://backbonejs.org) and includes examples on how to:

* Integrate OAuth logins [omniauth-fitbit](https://github.com/tkgospodinov/omniauth-fitbit)
* Store and use OAuth access tokens
* Create and use instances of `Fitgem::Client` using the stored OAuth access token

# Subscriptions

The Fitbit API allows for you to set up notification subscription so that when values change (via automatic syncs with the fitbit device) your applications can be notified automatically.  You can set up a default subscription callback URL via the [Fitbit dev site](https://dev.fitbit.com/ 'Fitbit Developer Site') and then use the Subscriptions API to add or remove subscriptions for individual users.

# Help Improve Fitgem!

The Fitbit REST API is in BETA right now, and so it will quite likely change over time (though I can't be sure whether it will be additive change or change of the non-backwards-compatible variety).  I aim to keep as up-to-date as I can but if you absolutely need functionality that isn't included here, **feel free to fork and implement it, then send me a pull request**.

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* **Make sure to add tests for it**. This is important so I don't break it in a future version unintentionally.
* **Please try not to mess with the Rakefile, version, or history**. If you want to have your own version, or is otherwise
necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Contributors

**Many, many thanks** to [everyone that has contributed to improve fitgem](https://github.com/whazzmaster/fitgem/graphs/contributors)!

# Copyright & Disclaimer

Copyright &copy; 2011-2013 Zachery Moneypenny. See LICENSE for further details. __I am not employed by [Fitbit](http://fitbit.com)__.  I created this library to assist other ruby developers in creating interesting applications on top of fitbit.com's data store and device data stream.

