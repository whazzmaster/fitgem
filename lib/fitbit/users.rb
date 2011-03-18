module Fitbit
  class Client
    
    def user_info(user_id)
      get("/user/#{user_id}/profile.json")
    end
    
  end
end
