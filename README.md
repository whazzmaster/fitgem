# Fitbit #

Provides access to fitbit.com data through their OAuth/REST API.  Without user authentication, any data
that the a fitbit.com user has denoted as 'public' can be gathered.  If a user logs in via OAuth then all
exposed data can be gathered.

The fitbit.com API is currently (March 2011) in BETA and is under development to extend its reach.  Since it is early in the lifecycle of the API I expect this gem to go through a number of revisions as we attempt to match the functionality of their platform.

# Usage #

If you've ever done any oauth client programming then the model will appear familiar.  Your first step, if haven't already, is to visit [https://dev.fitbit.com/](https://dev.fitbit.com/) and register your application to get your __consumer key__ and __consumer secret__ and set your __callback URL__, if appropriate for your app.  There's more documentation at the site so I won't belabor it here.

Below I've included two sample scripts that use Fitbit::Client to retrieve data.  One shows how to do the initial authorization _without_ doing the callback; the other shows how to use saved values from that initial authorization to reconnect with the API and get subsequent information.

	require 'fitbit'

	consumer_key = 'your-app-consumer-key'
	consumer_secret = 'your-app-consumer-secret'

	client = Fitbit::Client.new({:consumer_key => consumer_key, :consumer_secret => consumer_secret})

	request_token = client.request_token
	token = request_token.token
	secret = request_token.secret

	puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{token} and then enter the verifier code below and hit Enter"
	verifier = gets.chomp

	access_token = client.authorize(token, secret, { :oauth_verifier => verifier })

	puts "Verifier is: "+verifier
	puts "Token is:    "+access_token.token
	puts "Secret is:   "+access_token.secret

After running this and successfully connecting with verifier string that is displayed by the Fitbit site, you can reconnect using the script below.  To do so, take the token and secret that were printed out from the script above and paste them in where appropriate.  In this example we are using the client to get the

	require 'fitbit'

	consumer_key = 'your-app-consumer-key'
	consumer_secret = 'your-app-consumer-secret'
	token = 'token-received-in-above-script'
	secret = 'secret-received-in-above-script'
	user_id = 'your-user-id' # may be similar to '12345N'

	client = Fitbit::Client.new({:consumer_key => consumer_key, :consumer_secret => consumer_secret, :token => token, :secret => secret, :user_id => user_id})
	access_token = client.reconnect(token, secret)
 	p client.user_info

You can use this script to learn about the data structures that are returned from different API calls.  Since this library always retrieves JSON responses and then parses it into Ruby structures, you can interrogate the response data with simple calls to hashes.

## Usage in a Rails Application ##

We've started to develop an example app using the this fitbit client.  See [https://github.com/whazzmaster/fitbit-client](https://github.com/whazzmaster/fitbit-client) for more information.

# Subscriptions #

The Fitbit API allows for you to set up notification subscription so that when values change (via automatic syncs with the fitbit device) your applications can be notified automatically.  You can set up a default subscription callback URL via the [Fitbit dev site](https://dev.fitbit.com/ 'Fitbit Developer Site') and then use the Subscriptions API to add or remove subscriptions for individual users.

__Currently, notification management is experimental in this gem__.  We've built up code to add and remove specific types of subscriptions (foods, activities, sleep, body) but there seems to be some server-side issues with creating general, all-purpose subscriptions.

The docs are very fuzzy on subscription support at the moment; we definitely plan on extending this support once the backend has matured (or the online docs have improved).

# FAQs #

## What About ruby-fitbit? ##

There is a good looking gem called [ruby-fitbit](https://github.com/danmayer/ruby-fitbit "ruby-fitbit") that
also aims to collect data from the site.  It was created before they released their REST API and uses screen-scraping to gather the data rather than through their API.  I looked into forking it and refactoring
to use the new API but after looking through the code I felt it would be more of a total rewrite and so decided 
to create a new gem that I could design from scratch.

## This Code Looks Awfully Familiar ##

First off, that isn't a question. Second off... I shamelessly stole the 'Client' code from the excellent [twitter_oauth client](https://github.com/moomerman/twitter_oauth 'twitter_oauth') and refactored slightly to serve my ends for this particular interface.

I wouldn't have been able to spin up so fast without the example of twitter_oauth (due to my oauth nubness) to show how to use the [oauth](http://rubygems.org/gems/oauth 'oauth gem') gem in the typical auth scenario.

# Changelog #

* 11 April, 2011:
   * Fixed an issue where blank user id's are used and an error is thrown.
   * Added support for creating/removing subscriptions (this support is experimental for now, more tests coming)
* 24 March, 2011: 
   * Added logging of activities and foods
   * Added ability to add favorite activities and foods
   * Added ability to delete logged activities and foods, and remove favorite activities and foods
   * Refactored data_by_time_range for more testability
   * Added ability to query devices
* 19 March, 2011: 
   * Updated auth client to support first-time auth and reconnections (if you have previously been authorized and received token/secret). 
   * Added 'named' retrieval of activities and foods (recent_, favorite_, frequent_)
   * Added ability to log weight back to the site using the API
* 18 March, 2001: First revision. Supports the auth process via oauth, and retrieval of user info and activities.


#  Contributing to fitbit #

The Fitbit REST API is in BETA right now, and so it will quite likely change over time (though I can't be sure whether it will be additive change or change of the non-backwards-compatible variety).  I aim to keep as up-to-date as I can but if you absolutely need functionality that isn't included here, feel free to fork and implement it, then send me a pull request.
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright ###

Copyright (c) 2011 Zachery Moneypenny. See LICENSE.txt for further details.