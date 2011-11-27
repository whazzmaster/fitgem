module Fitgem
  class Client
    # Get information aobut current user
    #
    # @param [Hash] opts User information request data
    # @return [Hash] User information
    def user_info(opts={})
      get("/user/#{@user_id}/profile.json", opts)
    end

    # Update profile information for current user
    #
    # @param [Hash] opts User profile information
    # @option opts [String] :gender Gender, valid values are MALE, FEMALE, NA
    # @option opts [DateTime, Date, String] :birthday Birthday, in
    #   "yyyy-MM-dd" if a String
    # @option opts [Decimal, Integer, String] :height Height, in format
    #   "X.XX" if a string
    # @option opts [String] :nickname Nickname
    # @option opts [String] :fullName Full name
    # @option opts [String] :timezone Time zone; in the format
    #   "America/Los Angelos"
    #
    # @return [Hash] Hash containing updated profile information
    def update_user_info(opts)
      opts[:birthday] = format_date(opts[:birthday]) if opts[:birthday]
      post("/user/#{@user_id}/profile.json", opts)
    end

  end
end
