module Fitgem
  class Client

   # ==========================================
   #      Body Measurements Update Methods
   # ==========================================
   def body_measurements_on_date(date)
     get("/user/#{@user_id}/body/date/#{format_date(date)}.json")
   end

   # ==========================================
   #      Body Measurements Update Methods
   # ==========================================

   def log_weight(weight, date, options={})
     post("/user/#{@user_id}/body/weight.json", options.merge(:weight => weight, :date => format_date(date)))
   end

  end
end