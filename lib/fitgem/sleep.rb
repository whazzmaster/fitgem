module Fitgem
  class Client

    # ==========================================
    #          Sleep Retrieval Methods
    # ==========================================
    def sleep_on_date(date)
      get("/user/#{@user_id}/sleep/date/#{format_date(date)}.json")
    end

  end
end