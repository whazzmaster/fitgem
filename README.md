# Fitbit #

Provides access to fitbit.com data through their OAuth/REST API.  Without user authentication, any data
that the a fitbit.com user has denoted as 'public' can be gathered.  If a user logs in via OAuth then all
exposed data can be gathered.

The fitbit.com API is currently (March 2011) in BETA and is under development to extend its reach.  Since it is early in the lifecycle of the API I expect this gem to go through a number of revisions as we attempt to match the functionality of their platform.

# Changelog #

* 18 March, 2001: First revision. Supports the auth process via oauth, and retrieval of user info, activities, and foods.

# Usage #

If you've ever done any oauth client programming then the model will appear familiar.  Your first step, if haven't already, is to visit [https://dev.fitbit.com/](https://dev.fitbit.com/) and register your application to get your __consumer key__ and __consumer secret__ and set your __callback URL__, if appropriate for your app.  There's more documentation at the site so I won't belabor it here.

# FAQs #

## What About ruby-fitbit? ##

There is a good looking gem called [ruby-fitbit](https://github.com/danmayer/ruby-fitbit "ruby-fitbit") that
also aims to collect data from the site.  It was created before they released their REST API and uses screen-scraping to gather the data rather than through their API.  I looked into forking it and refactoring
to use the new API but after looking through the code I felt it would be more of a total rewrite and so decided 
to create a new gem that I could design from scratch.

## This Code Looks Awfully Familiar ##

First off, that isn't a question. Second off... I shamelessly stole the 'Client' code from the excellent [twitter_oauth client](https://github.com/moomerman/twitter_oauth 'twitter_oauth') and refactored slightly to serve my ends for this particular interface.

I wouldn't have been able to spin up so fast without the example of twitter_oauth (due to my oauth nubness) to show how to use the [oauth](http://rubygems.org/gems/oauth 'oauth gem')

#  Contributing to fitbit #
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

= Copyright

Copyright (c) 2011 Zachery Moneypenny. See LICENSE.txt for further details.

