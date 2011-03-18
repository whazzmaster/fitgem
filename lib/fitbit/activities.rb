module Fitbit
  class Client
    
    # Should return date as YYYY-MM-DD
    def format_date(date)
      date.strftime("%Y-%m-%d")
    end
    
    def activities(user_id, date)
      get("/user/#{user_id}/activities/date/#{format_date(date)}.json")
    end
    
  end
end