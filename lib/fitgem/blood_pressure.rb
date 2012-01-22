module Fitgem
  class Client
    # ==========================================
    #       Blood Pressure Retrieval Methods
    # ==========================================

    # Get blood pressure log entries for the supplied date
    #
    # @param [DateTime, Date, String] date
    # @return [Hash] Hash containing an average of the days logs, and a
    #   list of all individual entries
    def blood_pressure_on_date(date)
      get("/user/#{@user_id}/bp/date/#{format_date(date)}.json")
    end

    # ==========================================
    #        Blood Pressure Logging Methods
    # ==========================================

    # Log blood pressure information to fitbit
    #
    # @param [Hash] opts Heart rate data
    # @option opts [Integer, String] :systolic Systolic measurement (REQUIRED)
    # @option opts [Integer, String] :diastolic Diastolic measurement (REQUIRED)
    # @option opts [DateTime, Date, String] :date Log entry date (REQUIRED)
    # @option opts [DateTime, Time, String] :time Time of the measurement; hours and minutes in the format HH:mm
    #
    # @return [Hash] Summary of logged information
    def log_blood_pressure(opts)
      unless opts[:systolic] && opts[:diastolic] && opts[:date]
        raise Fitgem::InvalidArgumentError, "Must include :systolic, :diastolic, and :date in order to log blood pressure data"
      end

      opts[:date] = format_date(opts[:date])
      opts[:time] = format_time(opts[:time]) if opts[:time]
      post("/user/#{@user_id}/bp.json", opts)
    end

    # Delete logged blood pressure information
    #
    # @param [Integer, String] blood_pressure_log_id The id of previously logged
    #   blood pressure data
    # @return [Hash] Empty hash denotes success
    def delete_blood_pressure_log(blood_pressure_log_id)
      delete("/user/-/bp/#{blood_pressure_log_id}.json")
    end
  end
end