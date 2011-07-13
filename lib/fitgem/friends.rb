module Fitgem
  class Client

    # ==========================================
    #          Friend Retrieval Methods
    # ==========================================
    def friends
      get("/user/#{@user_id}/friends.json")
    end

    def weekly_leaderboard
      leaderboard('7d')
    end

    def monthly_leaderboard
      leaderboard('30d')
    end

    # ==========================================
    #       Invitation Management Methods
    # ==========================================
    def invite_friend(options)
      unless options[:email] || options[:user_id]
        raise InvalidArgumentError.new "add_friend hash argument must include :email or :user_id"
      end
      translated_options = {}
      translated_options[:invitedUserEmail] = options[:email] if options[:email]
      translated_options[:invitedUserId] = options[:user_id] if options[:user_id]
      post("/user/#{@user_id}/friends/invitations.json", translated_options)
    end

    def accept_invite(requestor_id)
      respond_to_invite(requestor_id, true)
    end

    def decline_invite(requestor_id)
      respond_to_invite(requestor_id, false)
    end

    private

    def leaderboard(range)
      get("/user/#{@user_id}/friends/leaderboard/#{range}.json")
    end

    def respond_to_invite(requestor_id, does_accept)
      options = { :accept => does_accept.to_s }
      post("/user/#{@user_id}/friends/invitations/#{requestor_id}.json", options)
    end
  end
end