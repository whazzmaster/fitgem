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
    #   "X.XX" if a String
    # @option opts [String] :nickname Nickname
    # @option opts [String] :aboutMe About Me description
    # @option opts [String] :fullName Full name
    # @option opts [String] :country; two-character code
    # @option opts [String] :state; two-character code
    # @option opts [String] :city
    # @option opts [Decimal, Integer, String] :strideLengthWalking Walking
    #   stride length, in format "X.XX" if a String
    # @option opts [Decimal, Integer, String] :strideLengthRunning Running
    #   stride length, in format "X.XX" if a String
    # @option opts [String] :weightUnit Default water unit on website
    #   (doesn't affect API); one of (en_US, en_GB, "any" for METRIC)
    # @option opts [String] :heightUnit Default height/distance unit
    #   on website (doesn't affect API); one of (en_US, "any" for METRIC)
    # @option opts [String] :waterUnit Default water unit on website
    #   (doesn't affect API); one of (en_US, "any" for METRIC)
    # @option opts [String] :glucoseUnit Default glucose unit on website
    #   (doesn't affect API); one of (en_US, "any" for METRIC)
    # @option opts [String] :timezone Time zone; in the format
    #   "America/Los Angelos"
    # @option opts [String] :foodsLocale Food Database Locale; in the
    #   format "xx_XX"
    # @option opts [String] :locale Locale of website (country/language);
    #   one of the locales, see https://wiki.fitbit.com/display/API/API-Update-User-Info
    #   for the currently supported values.
    #
    # @return [Hash] Hash containing updated profile information
    def update_user_info(opts)
      opts[:birthday] = format_date(opts[:birthday]) if opts[:birthday]
      post("/user/#{@user_id}/profile.json", opts)
    end

  end
end
