module Fitgem
  class Client
    # ==========================================
    #         Activity Retrieval Methods
    # ==========================================

    # Get a list of all activities
    #
    # The returned list includes all public activities plus any
    # activities that the current user created and logged
    #
    # @return [Hash] Hash tree of all activities
    def activities
      get("/activities.json")
    end

    # Get all of the logged activities on the supplied date
    #
    # @param [Datetime] date the date to retrieve logged activities for
    # @return [Hash] the activities logged on the supplied date
    def activities_on_date(date)
      get("/user/#{@user_id}/activities/date/#{format_date(date)}.json")
    end

    # Get activity information for a date range
    #
    # @param [String] activity to retrieve information for
    # @param [Datetime] start of date range
    # @param [Datetime] end of date range
    # @return [Hash] activity information for the given date range
    def activity_on_date_range(activity, start, finish)
      get("/user/#{@user_id}/activities/#{activity}/date/#{format_date(start)}/#{format_date(finish)}.json")
    end

    # Get a list of the frequently logged activities
    #
    # @return [Array] list of frequently logged activities
    def frequent_activities
      get("/user/#{@user_id}/activities/frequent.json")
    end

    # Get a list of recently logged activities
    #
    # @return [Array] list of of recently-logged activities
    def recent_activities
      get("/user/#{@user_id}/activities/recent.json")
    end

    # Get a list of activities marked as favorite by the user
    #
    # @return [Array] list of user-defined favorite activities
    def favorite_activities
      get("/user/#{@user_id}/activities/favorite.json")
    end

    # Get the detailed information for a single activity
    #
    # @param [Integer, String] id The ID of the activity.  This ID is
    #   typcially retrieved by browsing or searching the list of all
    #   available activities.  Must be a numerical ID in either Integer
    #   or String format.
    # @return [Hash] a hash structure containing detailed information
    #   about the activity
    def activity(id)
      get("/activities/#{id}.json")
    end

    # Get the activity statistics for the current user
    #
    # @return [Hash] Hash containing statistics for the activities that
    #   the user has logged
    def activity_statistics
      get("/user/#{@user_id}/activities.json")
    end

    # ==========================================
    #         Goal Retrieval Methods
    # ==========================================

    # Get the daily activity goals for the current user
    #
    # @return [Hash] Hash containing the calorie, distance, floors, and
    #   step goals for the current user
    #
    # @deprecated Use the daily_goals method; in v1.0.0 this method will
    #   be removed
    def goals
      get("/user/#{@user_id}/activities/goals/daily.json")
    end

    # Get the daily activity goals for the current user
    #
    # @return [Hash] Hash containing the calorie, distance, floors, and
    #   step goals for the current user
    #
    # @since v0.9.0
    def daily_goals
      goals
    end

    # Get the weekly activity goals for the current user
    #
    # @return [Hash] Hash containing the distance, floors and step goals
    #   for the current user
    def weekly_goals
      get("/user/#{@user_id}/activities/goals/weekly.json")
    end

    # ==========================================
    #         Activity Update Methods
    # ==========================================

    # Log an activity to fitbit
    #
    # @param [Hash] opts The options used to log the activity for the
    #   current user
    #
    # @option opts [String] :activityId The id of the activity, directory
    #   activity or intensity level activity. See activity types at
    #   {http://wiki.fitbit.com/display/API/API-Log-Activity} for more
    #   information. This value OR activityName is REQUIRED for all calls.
    # @option opts [String] :activityName The name of the activity to log.
    #   This value OR activityId is REQUIRED for alls.
    # @option opts [String, Integer] :durationMillis Activity duration in milliseconds.
    #   Must be a numeric value in Integer or String format. This value is REQUIRED for all calls.
    # @option opts [String] :startTime Activity start time, in the format "HH:mm" using hours
    #   and seconds. This value is REQUIRED for all calls.
    # @option opts [String] :date Activity date, in "yyyy-MM-dd" format. This
    #   value is REQUIRED for all calls.
    # @option opts [String] :distance Distance traveled, a string in the format "X.XX".  This value is
    #   REQUIRED when logging a directory activity, OPTIONAL otherwise.
    # @option opts [String, Integer] :manualCalories The number of calories
    #   to log against the activity. This value is REQUIRED if using the activityName,
    #   OPTIONAL otherwise.
    # @option opts [String] :distanceUnit One of {Fitgem::ApiDistanceUnit}.
    #   The "steps" units are available only for "Walking" and "Running"
    #   directory activities and their intensity levels
    #
    # @return [Hash] A hash with a summary of the logged activity
    def log_activity(opts)
      post("/user/#{@user_id}/activities.json", opts)
    end

    # Mark an activity as a favorite
    #
    # @param [String, Integer] :activity_id The ID of the activity.  This ID is
    #   typcially retrieved by browsing or searching the list of all
    #   available activities.  Must be a numerical ID in either Integer
    #   or String format.
    #
    # @return [Hash] Empty hash if successfully marked as a favorite
    def add_favorite_activity(activity_id)
      post("/user/#{@user_id}/activities/log/favorite/#{activity_id}.json")
    end

    # ==========================================
    #       Goal Creation/Update Methods
    # ==========================================

    # Create or update a user's daily goal
    #
    # @param [Hash] :opts
    #
    # @option opts [Symbol] :type The type of goal to create or update; must be one of
    #   :steps, :distance, :floors, or :caloriesOut. REQUIRED
    # @option opts [Decimal, Integer, String] :value The goal value; in the format 'X.XX'
    #   if a string. REQUIRED
    #
    # @since v0.9.0
    def create_or_update_daily_goal(opts)
      unless opts[:type] && [:steps, :distance, :floors, :caloriesOut].include?(opts[:type])
        raise InvalidArgumentError, 'Must specify type in order to create or update a daily goal. One of (:steps, :distance, :floors, or :caloriesOut) is required.'
      end

      unless opts[:value]
        raise InvalidArgumentError, 'Must specify value of the daily goal to be created or updated.'
      end

      post("/user/#{@user_id}/activities/goals/daily.json", opts)
    end

    # Create or update a user's weekly goal
    #
    # @param [Hash] :opts
    #
    # @option opts [Symbol] :type The type of goal to create or update; must be one of
    #   :steps, :distance, or :floors. REQUIRED
    # @option opts [Decimal, Integer, String] :value The goal value; in the format 'X.XX'
    #   if a string. REQUIRED
    #
    # @since v0.9.0
    def create_or_update_weekly_goal(opts)
      unless opts[:type] && [:steps, :distance, :floors].include?(opts[:type])
        raise InvalidArgumentError, 'Must specify type in order to create or update a weekly goal. One of (:steps, :distance, or :floors) is required.'
      end

      unless opts[:value]
        raise InvalidArgumentError, 'Must specify value of the weekly goal to be created or updated.'
      end

      post("/user/#{@user_id}/activities/goals/weekly.json", opts)
    end

    # ==========================================
    #         Activity Removal Methods
    # ==========================================

    # Delete a logged activity
    #
    # @param [String, Integer] :activity_log_id The ID of a previously
    #   logged activity. Note that this is NOT the activity ID itself, but
    #   the ID of the logging of the activity (returned when you call
    #   {#log_activity}).
    # @return [Hash]
    def delete_logged_activity(activity_log_id)
      delete("/user/#{@user_id}/activities/#{activity_log_id}.json")
    end

    # Unmark an activity as a favorite
    #
    # @param [String, Integer] :activity_id The activity ID of the
    #   activity to remove as a favorite.
    # @return [Hash]
    def remove_favorite_activity(activity_id)
      delete("/user/#{@user_id}/activities/log/favorite/#{activity_id}.json")
    end

    # ==========================================
    #      Intraday Activity Data Methods
    # ==========================================

    # Get intraday time series data for the specified resource
    #
    # @option opts [Symbol] :resource The sub-resource you want to retrieve time series data for; must
    #   be one of :calories, :steps, :floors, or :elevation. This value is REQUIRED for all calls.
    # @option opts [String, Datetime, Date] :date The date to retrieve a time series on. This value is
    #   REQUIRED for all calls.
    # @option opts [String] :detailLevel The resolution of the time series data; must be one of "1min"
    #   or "15min".
    #
    # @options opts [DateTime, Time, String] :startTime The start of the time period to request data for.
    # @options opts [DateTime, Time, String] :endTime The end of the time period to request data for.
    #
    # @return [Hash] A hash containing time series data
    def intraday_time_series(opts)
      unless opts[:resource] && [:calories, :steps, :distance, :floors, :elevation].include?(opts[:resource])
        raise Fitgem::InvalidArgumentError, 'Must specify resource to fetch intraday time series data for. One of (:calories, :steps, :distance, :floors, or :elevation) is required.'
      end

      unless opts[:date]
        raise Fitgem::InvalidArgumentError, 'Must specify the date to fetch intraday time series data for.'
      end

      unless opts[:detailLevel] && %w(1min 15min).include?(opts[:detailLevel])
        raise Fitgem::InvalidArgumentError, 'Must specify the data resolution to fetch intraday time series data for. One of (\"1d\" or \"15min\") is required.'
      end

      resource = opts.delete(:resource)
      date = format_date(opts.delete(:date))
      detail_level = opts.delete(:detailLevel)
      time_window_specified = opts[:startTime] || opts[:endTime]
      resource_path = "/user/#{@user_id}/activities/"

      if time_window_specified
        start_time = format_time(opts.delete(:startTime))
        end_time = format_time(opts.delete(:endTime))
        resource_path += "#{resource}/date/#{date}/1d/#{detail_level}/time/#{start_time}/#{end_time}.json"
      else
        resource_path += "#{resource}/date/#{date}/1d/#{detail_level}.json"
      end

      get(resource_path, opts)
    end
  end
end
