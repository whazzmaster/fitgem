module Fitgem
  class Client
   
    # Should return date as YYYY-MM-DD
    def format_date(date)
      if date.is_a? String
        return date
      elsif Date === date || Time === date || DateTime === date
        return date.strftime("%Y-%m-%d")
      else
        raise Fitgem::InvalidArgumentError, "Date used must be a date/time object or a string in the format YYYY=MM-DD; current argument is a #{date.class}"
      end
    end
     
  end
end