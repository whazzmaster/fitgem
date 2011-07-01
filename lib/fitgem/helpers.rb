module Fitgem
  class Client

    # Should return date as YYYY-MM-DD
    def format_date(date)
      if date.is_a? String
        case date
          when 'today'
            return Date.today.strftime("%Y-%m-%d")
          when 'yesterday'
            return (Date.today-1).strftime("%Y-%m-%d")
          else
            return date
        end
      elsif Date === date || Time === date || DateTime === date
        return date.strftime("%Y-%m-%d")
      else
        raise Fitgem::InvalidArgumentError, "Date used must be a date/time object or a string in the format YYYY-MM-DD; current argument is a #{date.class}"
      end
    end

  end
end