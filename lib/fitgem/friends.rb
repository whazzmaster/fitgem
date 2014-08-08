module Fitgem
  class Client
    # ==========================================
    #          Friend Retrieval Methods
    # ==========================================

    # Get a list of the current user's friends
    #
    # @return [Array] List of friends, each of which is a Hash
    #   containing friend information
    def friends
      get("/user/#{@user_id}/friends.json")
    end

    # Get the leaderboard of friends' weekly activities
    #
    # @return [Hash] Friends' information
    def leaderboard
      get("/user/#{@user_id}/friends/leaderboard.json")
    end

    # Get the leaderboard of friends' weekly activities
    #
    # @return [Hash] Friends' information
    #
    # @deprecated Monthly leaderboards are no longer available from Fitbit. Please update to use {#leaderboard}
    def monthly_leaderboard
      raise DeprecatedApiError, 'Fitbit no longer exposes a monthly leaderboard. See https://wiki.fitbit.com/display/API/API-Get-Friends-Leaderboard for more information. Use #leaderboard() instead.'
    end

    # Get the leaderboard of friends' weekly activities
    #
    # @return [Hash] Friends' information
    #
    # @deprecated Please update to use {#leaderboard}
    def weekly_leaderboard
      raise DeprecatedApiError, 'Fitbit now only exposes a weekly leaderboard, Use #leaderboard() instead.'
    end

    # ==========================================
    #       Invitation Management Methods
    # ==========================================

    # Create an invite for a user to connect with the current user as a friend
    #
    # In order to invite a user, either an :email or a valid :userId
    # must be supplied in the +opts+ param hash.
    #
    # @param [Hash] opts The invite data
    # @option opts [String] :email Email address of user to invite
    # @option opts [String] :userId User ID of the user to invite
    #
    # @return [Hash]
    def invite_friend(opts)
      unless opts[:email] || opts[:user_id]
        raise InvalidArgumentError.new "invite_friend hash argument must include :email or :user_id"
      end
      translated_options = {}
      translated_options[:invitedUserEmail] = opts[:email] if opts[:email]
      translated_options[:invitedUserId] = opts[:user_id] if opts[:user_id]
      post("/user/#{@user_id}/friends/invitations.json", translated_options)
    end

    # Accept a friend invite
    #
    # @param [String] requestor_id The ID of the requestor that sent the
    #   friend request
    # @return [Hash]
    def accept_invite(requestor_id)
      respond_to_invite(requestor_id, true)
    end

    # Decline a friend invite
    #
    # @param [String] requestor_id The ID of the requestor that sent the
    #   friend request
    # @return [Hash]
    def decline_invite(requestor_id)
      respond_to_invite(requestor_id, false)
    end

    private

    def respond_to_invite(requestor_id, does_accept)
      options = { :accept => does_accept.to_s }
      post("/user/#{@user_id}/friends/invitations/#{requestor_id}.json", options)
    end
  end
end
