module Fitgem
  class Client
    # ==========================================
    #       Glucose Retrieval Methods
    # ==========================================

    # Get glucose log entries for the supplied date
    #
    # @param [DateTime, Date, String] date
    # @return [Hash] Hash containing an average of the days logs, and a
    #   list of all individual entries
    def glucose_on_date(date)
      get("/user/#{@user_id}/glucose/date/#{format_date(date)}.json")
    end

    # ==========================================
    #        Glucose Logging Methods
    # ==========================================

    # Log glucose information to fitbit
    #
    # @param [Hash] opts Glucose data
    # @option opts [String] :tracker Glucose tracker name;
    #   predefined or custom tracker name (matches tracker name on the website) (this or :hba1c is REQUIRED)
    # @option opts [String] :hba1c HbA1c measurement; in the format "X.X" (this or :tracker is REQUIRED)
    # @option opts [String] :glucose Glucose measurement; in the format "X.X" (REQUIRED with :tracker, OPTIONAL otherwise)
    # @option opts [DateTime, Date, String] :date Log entry date (REQUIRED)
    # @option opts [DateTime, String] :time Time of the measurement; hours and minutes in the format HH:mm
    #
    # @return [Hash] Summary of logged information
    def log_glucose(opts)
      unless opts[:tracker] || opts[:hba1c]
        raise Fitgem::InvalidArgumentError, "Must include :tracker or :hba1c in order to log glucose data"
      end

      if opts[:tracker] && opts[:hba1c].nil? && opts[:glucose].nil?
        raise Fitgem::InvalidArgumentError, "Must include :glucose if using :tracker with no :hba1c value in order to log glucose data"
      end

      opts[:date] = format_date(opts[:date])
      opts[:time] = format_time(opts[:time]) if opts[:time]
      post("/user/#{@user_id}/glucose.json", opts)
    end
  end
end