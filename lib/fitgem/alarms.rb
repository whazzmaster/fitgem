module Fitgem
  class Client
    # ===================================================
    #   Add, Get, Delete  Silent Alarm to your profile
    # ===================================================

    # https://wiki.fitbit.com/display/API/API-Devices-Add-Alarm

    # See Documentation on fitbit wiki for list of Params
    # Also you'll need deviceID which you can get from the Client.devices method, see devices.rb
    def add_alarm(opts) 
      deviceID = opts[:deviceID]
      post("/user/#{@user_id}/devices/tracker/#{deviceID}/alarms.json", opts)
    end

    def get_alarms(deviceID)
      get("/user/#{@user_id}/devices/tracker/#{deviceID}/alarms.json")
    end

    def delete_alarm(alarmID, deviceID)
      delete("/user/#{@user_id}/devices/tracker/#{deviceID}/alarms/#{alarmID}.json")
    end

  end
end
