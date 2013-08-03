# @markup markdown
# @author Zachery Moneypenny

# fitgem changelog

## v0.8.0

#### 2013-08-03 Zachery Moneypenny <fitgem@whazzmaster.com>

* Add support for weekly goals
* Add support for silent alarms (including updates)
* Add support for intraday distance
* Add time zone support for usage of times
* Add support for badges

## v0.7.0

#### 2013-05-17 Zachery Moneypenny <fitgem@whazzmaster.com>

* Add support for intraday time series retrieval of various resources
* Removed rvmrc from project- use whatever ruby you want!
* Updated Travis CI configuration

## v0.6.1

#### 2013-02-28 Zachery Moneypenny <fitgem@whazzmaster.com>

* More unit tests
* Fix an issue where we weren't applying the `format_date` helper when constructing a date range fragment

## v0.6.0

* Streamline the README; add contributors link
* Removed FAQs from README
* Added support for daily activity goals
* Moved testing-focused gemspec dependencies to the Gemfile

#### 2013-02-13 Zachery Moneypenny <fitgem@whazzmaster.com>

## v0.5.2

#### 2012-03-04 Zachery Moneypenny <fitgem@whazzmaster.com>

* Added new <tt>symbolize_keys</tt> helper method for turning the string-key based return hashes into symbol-key based ones
* Added new <tt>label_for_measurement</tt> helper method to get the correct unit measurement label given a measurement type and the current user's ApiUnitSystem setting
* Added specs
* Added new <tt>connected?</tt> method on Fitgem::Client that will report whether API calls may be made
* Added <tt>InvalidUnitSystem</tt> error and <tt>InvalidMeasurementType</tt> error
* Fixed a small issue where date values were not being formatted correctly in calls to <tt>log_body_measurements</tt>

## v0.5.1

#### 2012-01-24 Zachery Moneypenny <fitgem@whazzmaster.com>

* Fix for creating and removing data subscriptions
* Updated specs

## v0.5.0

#### 2012-01-22 Zachery Moneypenny <fitgem@whazzmaster.com>

* Added view/log/delete access for blood pressure data
* Added view/log/delete access for glucose data
* Added view/log/delete access for heart rate data
* Added updated time series documentation for new endpoints
* Updated temporal information in the readme
* Added unit tests for <tt>format_time</tt> method
* Updated copyright date

## v0.4.0

#### 2011-11-29 Zachery Moneypenny <fitgem@whazzmaster.com>

* Added YARD documentation to thoroughly document code
* DEPRECATED: <tt>Fitgem::Client#log_weight</tt> method, use <tt>Fitgem::Client#log_body_measurements</tt> instead.
  The new method allows you to log more than weight (bicep size, body fat %, etc.)
* Added <tt>Fitgem::FoodFormType</tt> to be used in calls to <tt>Fitgem::Client#create_food</tt>
* Added <tt>Fitgem::Client#log_sleep</tt> to log sleep data to fitbit
* Added <tt>Fitgem::Client#delete_sleep_log</tt> to delete previously logged sleep data
* Added <tt>Fitgem::Client#activities</tt> method to get a list of all activities
* Added <tt>Fitgem::Client#activity_statistics</tt> method to get statistics for all logged activities
* Added to documentation of supported endpoints for <tt>Fitgem::Client#data_by_time_range</tt>
* Added unit tests for parameter validation for many methods
* Overhauled notifications methods, including extensive documentation,
  unit tests, refactoring, and a couple of bug fixes.  These methods now
  return both the HTTP status code and the JSON response body.  See https://wiki.fitbit.com/display/API/Subscriptions-API
  for information on how to interpret each of the error codes.
* Added fitgem to travis-ci for continuous integration (http://travis-ci.org/#!/whazzmaster/fitgem)
* Added fitgem to rubydoc.info (http://rubydoc.info/github/whazzmaster/fitgem/master/frames)
* Updated README
* Moved OAuth documentation from the README to the [fitgem wiki](https://github.com/whazzmaster/fitgem/wiki/The-OAuth-Process)

## v0.3.6

#### 2011-07-12 Zachery Moneypenny <fitgem@whazzmaster.com>

* Added friends support (get friends, friend leaderboard, create invites, accept/reject invites)
* Added water support (get water data per date)
* Added sleep support (get sleep data per date)
* Added ability to update user profile information

## Previous Releases

#### 2011-05-11 Zachery Moneypenny <fitgem@whazzmaster.com>

* Changed name and all references of this project from 'fitbit' to 'fitgem'

#### 2011-04-11 Zachery Moneypenny <fitgem@whazzmaster.com>

* Fixed an issue where blank user id's are used and an error is thrown.
* Added support for creating/removing subscriptions (this support is experimental for now, more tests coming)

#### 2011-03-24 Zachery Moneypenny <fitgem@whazzmaster.com>

* Added logging of activities and foods
* Added ability to add favorite activities and foods
* Added ability to delete logged activities and foods, and remove favorite activities and foods
* Refactored data_by_time_range for more testability
* Added ability to query devices

#### 2011-03-19 Zachery Moneypenny <fitgem@whazzmaster.com>

* Updated auth client to support first-time auth and reconnections (if you have previously been authorized and received token/secret).
* Added 'named' retrieval of activities and foods (recent_, favorite_, frequent_)
* Added ability to log weight back to the site using the API

#### 2011-03-18 Zachery Moneypenny <fitgem@whazzmaster.com>

* First revision. Supports the auth process via oauth, and retrieval of user info and activities.
