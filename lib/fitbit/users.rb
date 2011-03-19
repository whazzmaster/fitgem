module Fitbit
  class Client
    
    def user_info(options = {})    
      get("/user/#{@user_id}/profile.json")
    end
    
  end
end
