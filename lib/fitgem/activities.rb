module Fitgem
  class Client

    # ==========================================
    #         Activity Retrieval Methods
    # ==========================================
    def activities_on_date(date)
      get("/user/#{@user_id}/activities/date/#{format_date(date)}.json")
    end

    def frequent_activities()
      get("/user/#{@user_id}/activities/frequent.json")
    end

    def recent_activities()
      get("/user/#{@user_id}/activities/recent.json")
    end

    def favorite_activities()
      get("/user/#{@user_id}/activities/favorite.json")
    end

    def activity(id, options ={})
      get("/activities/#{id}.json")
    end

    # ==========================================
    #         Activity Update Methods
    # ==========================================

    # The following values are REQUIRED when logging an activity:
    #     options[:activityId]      =>  The id of the activity, directory activity or intensity level activity. See activity types at http://wiki.fitbit.com/display/API/API-Log-Activity for more information.
    #     options[:durationMillis]  =>  Activity duration in milliseconds
    #     options[:startTime]       =>  Activity start time hours and minutes in the format HH:mm
    #     options[:date]            =>  Set to today's date when not provided
    #
    # The following value is REQUIRED when logging directory activity, OPTIONAL otherwise
    #     options[:distance]
    #
    # The following values are OPTIONAL when logging an activity:
    #     options[:distanceUnit]    => One of Fitgem::ApiDistanceUnit values
    #     options[:manualCalories]  => Number of calories determined manually
    def log_activity(options)
      post("/user/#{@user_id}/activities.json", options)
    end

    def add_favorite_activity(activity_id)
      post("/user/#{@user_id}/activities/log/favorite/#{activity_id}.json")
    end

    # ==========================================
    #         Activity Removal Methods
    # ==========================================

    def delete_logged_activity(activity_log_id)
      delete("/user/#{@user_id}/activities/#{activity_log_id}.json")
    end

    def remove_favorite_activity(activity_id)
      delete("/user/#{@user_id}/activities/log/favorite/#{activity_id}.json")

    end
  end
end