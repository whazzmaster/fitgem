module Fitgem
  class Client
    # ==========================================
    #       Heart Rate Retrieval Methods
    # ==========================================

    # Get heart rate log entries for the supplied date
    #
    # @param [DateTime, Date, String] date
    # @return [Hash] Hash containing an average of the days logs, and a
    #   list of all individual entries
    def heart_rate_on_date(date)
      get("/user/#{@user_id}/heart/date/#{format_date(date)}.json")
    end

    # Get a list of heart rate entries for the specified period
    #
    # @params [Hash] opts heart rate options
    # @option opts [Date] base_date The end date when period is provided, in the
    #   format yyyy-MM-dd or today; range start date when a date range is provided.
    # @option opts [String] period The date range period. One of 1d, 7d, 30d, 1w, 1m
    # @option opts [Date] end_date Range end date when date range is provided.
    #
    # @return [Hash] A hash containing heart rate entries
    def heart_rate(opts = {})
      date_range_opts = opts.dup
      date_range_opts.delete(:date)
      get uri_with_date_range("/user/#{@user_id}/activities/heart", date_range_opts)
    end

    # ==========================================
    #        Heart Rate Logging Methods
    # ==========================================

    # Log heart rate information to fitbit
    #
    # @param [Hash] opts Heart rate data
    # @option opts [String] :tracker Heart rate tracker name;
    #   predefined or custom tracker name (matches tracker name on the website) (REQUIRED)
    # @option opts [Integer, String] :heart_rate Heart rate measurement (REQUIRED)
    # @option opts [DateTime, Date, String] :date Log entry date (REQUIRED)
    # @option opts [DateTime, String] :time Time of the measurement; hours and minutes in the format HH:mm
    #
    # @return [Hash] Summary of logged information
    def log_heart_rate(opts)
      unless opts[:tracker] && opts[:heart_rate] && opts[:date]
        raise Fitgem::InvalidArgumentError, "Must include :tracker, :heart_rate, and :date in order to log heart rate data"
      end

      opts[:heartRate] = opts.delete :heart_rate
      opts[:date] = format_date(opts[:date])
      opts[:time] = format_time(opts[:time]) if opts[:time]
      post("/user/#{@user_id}/heart.json", opts)
    end

    # Delete logged heart rate information
    #
    # @param [Integer, String] heart_rate_log_id The id of previously logged
    #   heart rate data
    # @return [Hash] Empty hash denotes success
    def delete_heart_rate_log(heart_rate_log_id)
      delete("/user/-/heart/#{heart_rate_log_id}.json")
    end
  end
end