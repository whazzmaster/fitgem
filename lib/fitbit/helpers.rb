module Fitbit
  class Client
   
    # Should return date as YYYY-MM-DD
    def format_date(date)
      if Date === date || Time === date
        date.strftime("%Y-%m-%d")
      else
        raise Fitbit::InvalidArgumentError, "Date used must be a date/time object; current argument is a #{date.class}"
      end
    end
     
  end
end