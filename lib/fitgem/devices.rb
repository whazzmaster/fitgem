module Fitgem
  class Client
    # ==========================================
    #          Device Retrieval Methods
    # ==========================================

    # Get a list of devices for the current account
    #
    # @return [Array] An array of hashes, each of which describes
    #   a device attaached to the current account
    def devices
      get("/user/#{@user_id}/devices.json")
    end

    # Get the details about a specific device
    #
    # The ID required for this call could be found by getting the list
    # of devices with a call to {#devices}.
    #
    # @param [Integer, String] device_id The ID of the device to get
    #   details for
    # @return [Hash] Hash containing device information
    def device_info(device_id)
      get("/user/#{@user_id}/devices/#{device_id}.json")
    end
  end
end
