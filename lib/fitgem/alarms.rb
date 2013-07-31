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

    # Update an existing alarm
    #
    # @param [Integer, String] alarm_id The id of the alarm
    # @param [Integer, String] device_id The id of the device you would like to
    #   manage the alarm on
    # @param [Hash] opts Alarm settings
    # @option opts [String] :time Time of the alarm in the format XX:XX+XX:XX, time
    #   with timezone
    # @option opts [TrueClass, FalseClass] :enabled
    # @option opts [TrueClass, FalseClass] :recurring One time or recurring alarm
    # @option opts [String] :weekDays The days the alarm is active on as a list of
    #   comma separated values: MONDAY, WEDNESDAY, SATURDAY. For recurring only
    # @option opts [Integer] :snoozeLength Minutes between the alarms
    # @option opts [Integer] :snoozeCount Maximum snooze count
    # @option opts [String] :label Label for the alarm
    #
    # @return [Hash] Hash containing updated alarm settings
    def update_alarm(alarm_id, device_id, opts)
      post("/user/#{@user_id}/devices/tracker/#{device_id}/alarms/#{alarm_id}.json", opts)
    end

  end
end
