module Fitgem
  class Client

    # ==========================================
    #          Water Retrieval Methods
    # ==========================================
    def water_on_date(date)
      get("/user/#{@user_id}/foods/log/water/date/#{format_date(date)}.json")
    end

  end
end