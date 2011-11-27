module Fitgem
  class Client
    # ==========================================
    #          Water Retrieval Methods
    # ==========================================

    # Get water log entries for the supplied date
    #
    # @param [DateTime, Date, String] date
    # @return [Hash] Hash containing the summary of the days logs, and a
    #   list of all individual entries
    def water_on_date(date)
      get("/user/#{@user_id}/foods/log/water/date/#{format_date(date)}.json")
    end


    # ==========================================
    #          Water Logging Methods
    # ==========================================

    # Log water consumption to fitbit
    #
    # @param [Hash] opts Water consumption data
    # @option opts [Integer, Decimal, String] :amount Amount of water
    #   consumed; if String must be in "X.X" format
    # @option opts [String] :unit Unit of water consumed; valid values
    #   are ("ml", "fl oz" or "cup")
    # @option opts [DateTime, Date, String] :date Date of water
    #   consumption
    #
    # @return [Hash] Summary of logged information
    def log_water(opts)
      unless opts[:amount] && opts[:date]
        raise Fitgem::InvalidArgumentError, "Must include both an :amount and :date to log water"
      end

      opts[:date] = format_date(opts[:date])
      post("/user/#{@user_id}/foods/log/water.json",opts)
    end

    # Delete logged water consumption
    #
    # @param [Integer, String] water_log_id The id of previously logged
    #   water consumption
    # @return [Hash] Empty hash denotes success
    def delete_water_log(water_log_id)
      delete("/user/-/foods/log/water/#{water_log_id}.json")
    end
  end
end
