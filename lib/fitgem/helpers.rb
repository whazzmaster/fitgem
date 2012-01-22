module Fitgem
  class Client
    # Format any of a variety of date types into the formatted string
    # required when using the fitbit API.
    #
    # The date parameter can take several different kind of objects: a
    # DateTime object, a Date object, a Time object or a String object.  Furthermore,
    # the string object may be either the date in a preformatted string
    # ("yyyy-MM-dd"), or it may be the string values "today" or
    # "tomorrow".
    #
    # @param [DateTime, Date, Time, String] date The object to format into a
    #   date string
    # @raise [Fitgem::InvalidDateArgument] Raised when the object is
    #   not a DateTime, Date, Time or a valid (yyyy-MM-dd) String object
    # @return [String] Date in "yyyy-MM-dd" string format
    def format_date(date)
      if date.is_a? String
        case date
          when 'today'
            return Date.today.strftime("%Y-%m-%d")
          when 'yesterday'
            return (Date.today-1).strftime("%Y-%m-%d")
          else
            unless date =~ /\d{4}\-\d{2}\-\d{2}/
              raise Fitgem::InvalidDateArgument, "Invalid date (#{date}), must be in yyyy-MM-dd format"
            end
            return date
        end
      elsif Date === date || Time === date || DateTime === date
        return date.strftime("%Y-%m-%d")
      else
        raise Fitgem::InvalidDateArgument, "Date used must be a date/time object or a string in the format YYYY-MM-DD; supplied argument is a #{date.class}"
      end
    end

    # Format any of a variety of time-related types into the formatted string
    # required when using the fitbit API.
    #
    # The time parameter can take several different kind of objects: a DateTime object,
    # a Time object, or a String Object.  Furthermore, the string object may be either
    # the date in a preformatted string ("HH:mm"), or it may be the string value "now" to
    # indicate that the time value used is the current localtime.
    #
    # @param [DateTime, Time, String] time The object to format into a time string
    # @raise [Fitgem::InvalidTimeArgument] Raised when the parameter object is not a
    #   DateTime, Time, or a valid ("HH:mm" or "now") string object
    # @return [String] Date in "HH:mm" string format
    def format_time(time)
      if time.is_a? String
        case time
          when 'now'
            return DateTime.now.strftime("%H:%M")
          else
            unless time =~ /\d{2}\:\d{2}/
              raise Fitgem::InvalidTimeArgument, "Invalid time (#{time}), must be in HH:mm format"
            end
            return time
        end
      elsif DateTime === time || Time === time
        return time.strftime("%H:%M")
      else
        raise Fitgem::InvalidTimeArgument, "Date used must be a valid time object or a string in the format HH:mm; supplied argument is a #{time.class}"
      end
    end
  end
end
