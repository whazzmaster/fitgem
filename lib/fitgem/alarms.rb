module Fitgem
  class Client
    # Add a silent alarm to your profile
    #
    # @param [Hash] opts Alarm options
    # @option opts [Integer, String] device_id The id of the device you would like
    #   to manage the alarm on
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
    # @return [Hash] Hash containing the alarm settings
    def add_alarm(opts)
      device_id = opts[:device_id]
      post("/user/#{@user_id}/devices/tracker/#{device_id}/alarms.json", opts)
    end

    # Retrieve the silent alarms of your device
    #
    # @param [Integer, String] device_id The id of the device you would like to
    #   manage the alarms of
    #
    # @return [Hash] Hash containing the alarms and it's settings
    def get_alarms(device_id)
      get("/user/#{@user_id}/devices/tracker/#{device_id}/alarms.json")
    end

    # Remove a silent alarm from your profile
    #
    # @param [Integer, String] alarm_id The id of the alarm
    # @param [Integer, String] device_id The id of the device you would like to
    #   manage the alarm on
    #
    # @return [Hash] Empty hash denotes success
    def delete_alarm(alarm_id, device_id)
      delete("/user/#{@user_id}/devices/tracker/#{device_id}/alarms/#{alarm_id}.json")
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
