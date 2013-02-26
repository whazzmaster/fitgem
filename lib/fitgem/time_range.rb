module Fitgem
  class Client
    # Gets historical resource data in the time range specified by 
    # options hash param.  The time range can either be specified by 
    # :base_date and :end_date OR by using :base_date and a :period
    # (supported periods are 1d, 7d, 30d, 1w, 1m, 3m, 6m, 1y, max)
    #
    # Supported values for +resource_path+ are:
    #
    # Food:
    #   /foods/log/caloriesIn
    #   /foods/log/water
    # 
    # Activity:
    #   /activities/log/calories
    #   /activities/log/steps
    #   /activities/log/distance
    #   /activities/log/floors
    #   /activities/log/elevation
    #   /activities/log/minutesSedentary
    #   /activities/log/minutesLightlyActive
    #   /activities/log/minutesFairlyActive
    #   /activities/log/minutesVeryActive
    #   /activities/log/activeScore
    #   /activities/log/activityCalories
    #
    # Raw Tracker Activity:
    #   /activities/tracker/calories
    #   /activities/tracker/steps
    #   /activities/tracker/distance
    #   /activities/tracker/floors
    #   /activities/tracker/elevation
    #   /activities/tracker/activeScore
    #
    # Sleep:
    #   /sleep/startTime
    #   /sleep/timeInBed
    #   /sleep/minutesAsleep
    #   /sleep/awakeningsCount
    #   /sleep/minutesAwake
    #   /sleep/minutesToFallAsleep
    #   /sleep/minutesAfterWakeup
    #   /sleep/efficiency
    # 
    # Body:
    #   /body/weight
    #   /body/bmi
    #   /body/fat
    #
    # @param [String] resource_path The resource path to get data for
    #   (see note above)
    # @param [Hash] opts The options to specify date ranges, etc.
    # @option opts [DateTime, Date, String] :base_date The start date of the period
    # @option opts [DateTime, Date, String] :end_date The end date of the period
    # @option opts [String] :period The period (valid values: 1d, 7d, 30d, 1w, 1m, 3m, 6m, 1y, max)
    #
    # @return [Hash] Hash containing an array of objects that match your
    #   request
    #
    # @example To get the floors traveled for the week of October 24th
    #   data_by_time_range("/activities/log/floors", {:base_date => "2011-10-24", :period => "7d"})
    #
    # @example To get all of the body weight logs from April 3rd until July 27th
    #   data_by_time_range("/body/weight", {:base_date => "2011-03-03", :end_date => "2011-07-27"})
    #
    def data_by_time_range(resource_path, opts)
      range = construct_date_range_fragment(opts)
      get("/user/#{@user_id}#{resource_path}/#{range}.json")
    end

    # protected

    def construct_date_range_fragment(options)
      range_str = "date/"
      if options[:base_date] && options[:period]
        range_str += "#{format_date(options[:base_date])}/#{options[:period]}"
      elsif options[:base_date] && options[:end_date]
        range_str += "#{format_date(options[:base_date])}/#{format_date(options[:end_date])}"
      else
        raise Fitgem::InvalidTimeRange, "Must supply either base_date and period OR base_date and end_date"
      end
      range_str
    end

  end
end
