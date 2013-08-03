module Fitgem
  class Client

    # Get a list of all badges earned
    #
    # @return [Hash] Hash containing an array of badges
    def badges
      get("/user/#{@user_id}/badges.json")
    end

  end
end
