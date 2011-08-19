module Fitgem
  class Client

    # ==========================================
    #          Water Retrieval Methods
    # ==========================================
    def water_on_date(date)
      get("/user/#{@user_id}/foods/log/water/date/#{format_date(date)}.json")
    end


    # ==========================================
    #          Water Logging Methods
    # ==========================================

    # options[:amount]    Required
    # options[:unit]      Optional    ("ml", "fl oz" or "cup")
    # options[:date]      Required    yyyy-MM-dd format
    def log_water(options)
      unless options[:amount] && options[:date]
        raise "Must include both an :amount and :date to log water"
      end
      post("/user/#{@user_id}/foods/log/water.json",options)
    end

    # ==========================================
    #        Water Log Deletion Methods
    # ==========================================

    def delete_water_log(log_id)
      begin
        delete("/user/-/foods/log/water/#{log_id}.json")
      rescue TypeError
        # OAuth library responds badly to nil responses by fitbit's delete methods
      end
    end
  end
end