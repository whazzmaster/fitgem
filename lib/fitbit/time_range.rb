module Fitbit
  class Client
    
    # Gets historical resource data in the time range specified by 
    # options param.  The time range can either be specified by 
    # :base_date and :end_date OR by using :base_date and a :period
    # (supported periods are 1d, 7d, 30d, 1w, 1m, 3m, 6m, 1y, max)
    #
    # Example values for resource_path are below:
    #
    # Food:
    # /foods/log/caloriesIn
    # 
    # Activity:
    # /activities/log/calories
    # /activities/log/steps
    # /activities/log/distance
    # /activities/log/minutesSedentary
    # /activities/log/minutesLightlyActive
    # /activities/log/minutesFairlyActive
    # /activities/log/minutesVeryActive
    # /activities/log/activeScore
    # /activities/log/activityCalories
    # 
    # Sleep:
    # /sleep/minutesAsleep
    # /sleep/minutesAwake
    # /sleep/awakeningsCount
    # /sleep/timeInBed
    # 
    # Body:
    # /body/weight
    # /body/bmi
    # /body/fat
    def data_by_time_range(resource_path, options)
      range_str = construct_date_range_fragment(options)
      get("/user/#{@user_id}#{resource_path}/#{range_str}.json")
    end
    
    def construct_date_range_fragment(options)
      range_str = "date/"
      if options[:base_date] && options[:period]
        range_str += "#{options[:base_date]}/#{options[:period]}"
      elsif options[:base_date] && options[:end_date]
        range_str += "#{options[:base_date]}/#{options[:end_date]}"
      else
        raise Fitbit::InvalidTimeRange, "Must supply either base_date and period OR base_date and end_date"
      end
      range_str
    end
    
  end
end