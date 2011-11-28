ChangeLog

2011-11-** Zachery Moneypenny <fitgem@whazzmaster.com>

	* Added YARD documentation to thoroughly document code

	* DEPRECATED: Fitgem::Client#log_weight method, use Fitgem::Client#log_body_measurements instead.  
		The new method allows you to log more than weight (bicep size, body fat %, etc.)
	
	* Fixed bug in Fitgem::ApiUnitSystem where the value for each unit system was incorrect for what 
		the API was expecting.  Changed "en_US" to "en-US" and "en_GB" to "en-GB". Also provided
		documentation for the units.

	* Added Fitgem::FoodFormType to be used in calls to Fitgem::Client#create_food

	* Added Fitgem::Client#log_sleep to log sleep data to fitbit

	* Added Fitgem::Client#delete_sleep_log to delete previously logged sleep data

	* Added unit tests for parameter validation for many methods

	* Overhauled notifications methods, including extensive documentation,
		unit tests, refactoring, and a couple of bug fixes.

2011-07-12 Zachery Moneypenny <fitgem@whazzmaster.com>

	* Added friends support (get friends, friend leaderboard, create invites, accept/reject invites)

	* Added water support (get water data per date)
  
	* Added sleep support (get sleep data per date)
	
	* Added ability to update user profile information

2011-05-11 Zachery Moneypenny <fitgem@whazzmaster.com>

	* Changed name and all references of this project from 'fitbit' to 'fitgem'

2011-04-11 Zachery Moneypenny <fitgem@whazzmaster.com>

	* Fixed an issue where blank user id's are used and an error is thrown.
  
	* Added support for creating/removing subscriptions (this support is experimental for now, more tests coming)

2011-03-24 Zachery Moneypenny <fitgem@whazzmaster.com>

  * Added logging of activities and foods
  
	* Added ability to add favorite activities and foods
  
	* Added ability to delete logged activities and foods, and remove favorite activities and foods
  
	* Refactored data_by_time_range for more testability
  
	* Added ability to query devices

2011-03-19 Zachery Moneypenny <fitgem@whazzmaster.com>

  * Updated auth client to support first-time auth and reconnections (if you have previously been authorized and received token/secret).
  
	* Added 'named' retrieval of activities and foods (recent_, favorite_, frequent_)
  
	* Added ability to log weight back to the site using the API

2011-03-18 Zachery Moneypenny <fitgem@whazzmaster.com>

	* First revision. Supports the auth process via oauth, and retrieval of user info and activities.
