# fitgem [![Build Status](https://secure.travis-ci.org/whazzmaster/fitgem.png)](http://travis-ci.org/whazzmaster/fitgem)

Provides access to [fitbit.com](http://www.fitbit.com) data through [their REST
API](http://dev.fitbit.com).  Fitgem can pull data with or without a valid
OAUth access_token. Without an access_token you can only gather data that a
user has denoted as 'public'.  However, if an access_token is provided then all
exposed data can be gathered for the logged-in account.

### WARNING: THIS GEM IS NO LONGER UNDER ACTIVE DEVELOPMENT

**I'm looking for a new maintainer- I've grown to dislike Fitbit's products and
platform and don't have much interest in this library anymore. Please contact
me if you're interested in taking over development.**

**The final release will be 1.0.0, which changes over the gem to use OAuth2.**

### Installation

Install fitgem

```bash
$ gem install fitgem
```

or add it to your Gemfile

```ruby
gem 'fitgem'
```

### API Reference
Comprehensive method documentation is [available
online](http://www.rubydoc.info/gems/fitbit/0.2.0/frames).

The best way to connect your users to the Fitbit API is to use
[omniauth-fitbit](https://github.com/tkgospodinov/omniauth-fitbit) to integrate
Fitbit accounts into your web application. Once you have a Fitbit API OAuth
`access_token` for a user it's simple to create a client object through fitgem
to send and receive fitness data.

### Contributing to Fitgem
The Fitbit REST API is in BETA right now, and so it will quite likely change
over time.  I aim to keep as up-to-date as I can but if you absolutely need
functionality that isn't included here, **feel free to fork and implement it,
then send me a pull request**.

* Check out the latest master to make sure the feature hasn't been implemented
    or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it
    and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* **Make sure to add tests for it**. This is important so I don't break it in a
    future version unintentionally.
* **Please try not to mess with the Rakefile, version, or history**. If you
    want to have your own version, or is otherwise necessary, that is fine, but
    please isolate to its own commit so I can cherry-pick around it.

#### Contributors

**Many, many thanks** to [everyone that has contributed to improve
fitgem](https://github.com/whazzmaster/fitgem/graphs/contributors)!

#### License

See LICENSE for further details.
