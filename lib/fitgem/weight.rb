module Fitgem
  class Client
   
   # ==========================================
   #          Weight Update Methods
   # ==========================================
   
   def log_weight(weight, date, options={})
     post("/user/#{@user_id}/body/weight.json", options.merge(:weight => weight, :date => format_date(date)))
   end
   
  end
end