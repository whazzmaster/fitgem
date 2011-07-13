module Fitgem
  class Client

    def user_info(options = {})
      get("/user/#{@user_id}/profile.json")
    end

    # options[:gender] optional Gender; (MALE/FEMALE/NA)
    # options[:birthday] optional Date of Birth; in the format yyyy-MM-dd
    # options[:height] optional Height
    # options[:nickname] optional Nickname
    # options[:fullName] optional Full name
    # options[:timezone] optional Timezone; in the format "America/Los_Angeles"
    def update_user_info(options)
      post("/user/#{@user_id}/profile.json", options)
    end

  end
end
