module Fitgem
  class Client

    # ==========================================
    #          Food Retrieval Methods
    # ==========================================
       
    def foods_on_date(date)
      get("/user/#{@user_id}/foods/log/date/#{format_date(date)}.json")
    end
    
    def recent_foods()
      get("/user/#{@user_id}/foods/log/recent.json")
    end
    
    def frequent_foods()
      get("/user/#{@user_id}/foods/log/frequent.json")
    end
    
    def favorite_foods()
      get("/user/#{@user_id}/foods/log/favorite.json")
    end
    
    def foods_units()
      get("/foods/units.json")
    end
    
    def find_food(query_string)
      get("/foods/search.json?query=#{URI.escape(query_string)}")
    end
    
    # ==========================================
    #           Food Update Methods
    # ==========================================
        
    # Send the following required ID's in the options hash:
    #   options[:foodId]      => ID of the food to log
    #   options[:mealTypeId]  => ID of the meal to log the food for
    #   options[:unitId]      => ID of the unit to log with the food
    #      (typically retrieved via a previous call to get Foods (all, recent, frequent, favorite) or Food Units. )
    #   options[:amount]      => Amount consumed of the selected unit; a floating point number
    #   options[:date]        => Log date in the format yyyy-MM-dd 
    def log_food(options)
      post("/user/#{@user_id}/foods/log.json", options)
    end

    def add_favorite_food(food_id)
      post("/user/#{@user_id}/foods/log/favorite/#{food_id}.json")
    end
    
    # ==========================================
    #           Food Removal Methods
    # ==========================================    
    
    def delete_logged_food(food_log_id)
      delete("/user/#{@user_id}/foods/log/#{food_log_id}.json")
    end
    
    def remove_favorite_food(food_id)
      delete("/user/#{@user_id}/foods/favorite/#{food_id}.json")
    end
  end
end