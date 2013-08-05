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

    # Get the weekly leaderboard of friends' activities
    #
    # @return [Hash] Friends' information
    def weekly_leaderboard
      get("/user/#{@user_id}/friends/leaderboard.json")
    end

    # Get the monthly leaderboard of friends' activities
    #
    # @return [Hash] Friends' information
    def monthly_leaderboard
      leaderboard('30d')
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

    def leaderboard(range)
      get("/user/#{@user_id}/friends/leaders/#{range}.json")
    end

    def respond_to_invite(requestor_id, does_accept)
      options = { :accept => does_accept.to_s }
      post("/user/#{@user_id}/friends/invitations/#{requestor_id}.json", options)
    end
  end
end
