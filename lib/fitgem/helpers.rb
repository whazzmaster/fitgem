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
  end
end
