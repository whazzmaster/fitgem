module Fitbit  
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
    #     options[:activityId]      =>  The activity id
    #     options[:durationMillis]  =>  Activity duration in milliseconds 
    #     options[:distance]        =>  Distance covered during activity date
    #     options[:startTime]       =>  Activity start time hours and minutes in the format HH:mm
    # The following values are OPTIONAL when logging an activity:
    #     options[:date]            =>  set to today's date when not provided 
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