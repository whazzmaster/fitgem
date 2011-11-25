module Fitgem
  class Client
    # ==========================================
    #          Sleep Retrieval Methods
    # ==========================================

    # Get sleep data for specified date
    #
    # @param [DateTime, Date, String] date
    # @return [Array] List of sleep items for the supplied date
    def sleep_on_date(date)
      get("/user/#{@user_id}/sleep/date/#{format_date(date)}.json")
    end

    # ==========================================
    #          Sleep Logging Methods
    # ==========================================

    # Log sleep data to fitbit for current user
    #
    # All aspects of the options hash are REQUIRED.
    #
    # @param [Hash] opts Sleep data to log
    # @option opts [String] :startTime Hours and minutes in the format "HH:mm"
    # @option opts [Integer, String] :duration Sleep duration, in miliseconds
    # @option opts [DateTime, Date, String] :date Sleep log entry date;
    #   if a string it must be in the yyyy-MM-dd format, or the values
    #   'today' or 'tomorrow'
    #
    # @return [Hash] Summary of the logged sleep data
    #
    # @since v0.4.0
    def log_sleep(opts)
      post("/user/#{@user_id}/sleep.json", opts)
    end

    # Delete logged sleep data
    #
    # The sleep log id is the one returned when sleep data is recorded
    # via {#log_sleep}.
    #
    # @param [Integer, String] Sleep log id
    # @return [Hash] Empty hash denotes successful deletion
    #
    # @since v0.4.0
    def delete_sleep_log(sleep_log_id)
      delete("/user/#{@user_id}/sleep/#{sleep_log_id}.json")
    end
  end
end
