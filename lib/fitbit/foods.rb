module Fitbit
  class Client
   
    def foods_on_date(date, options={})
      get("/user/#{@user_id}/foods/log/date/#{format_date(date)}.json")
    end
    
    def recent_foods(options={})
      get("/user/#{@user_id}/foods/log/recent.json")
    end
    
    def frequent_foods(options={})
      get("/user/#{@user_id}/foods/log/frequent.json")
    end
    
    def favorite_foods(options={})
      get("/user/#{@user_id}/foods/log/favorite.json")
    end
    
    def foods_units(options={})
      get("/foods/units.json")
    end
    
  end
end