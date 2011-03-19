module Fitbit
  class Client
   
   # def weight_on_date(date, options={})
   #  get("/user/#{@user_id}/body/weight/#{format_date(date)}.json")
   # end
   
   def log_weight(weight, date, options={})
     post("/user/#{@user_id}/body/weight.json", options.merge(:weight => weight, :date => format_date(date)))
   end
   
  end
end