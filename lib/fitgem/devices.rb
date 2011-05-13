module Fitgem
  class Client
    
    # ==========================================
    #          Device Retrieval Methods
    # ==========================================
   
    def devices
      get("/user/#{@user_id}/devices.json")
    end
    
    def device_info(device_id)
      get("/user/#{@user_id}/devices/#{device_id}.json")
    end
    
  end
end