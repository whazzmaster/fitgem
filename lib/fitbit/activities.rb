module Fitbit  
  class Client
        
    def activities_on_date(date, options = {})
      get("/user/#{@user_id}/activities/date/#{format_date(date)}.json")
    end
    
    def frequent_activities(options = {})
      get("/user/#{@user_id}/activities/frequent.json")
    end
    
    def recent_activities(options = {})
      get("/user/#{@user_id}/activities/recent.json")
    end
    
    def favorite_activities(options = {})
      get("/user/#{@user_id}/activities/favorite.json")
    end
    
  end
end