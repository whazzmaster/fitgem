module Fitbit
  class Client
    
    def create_general_subscription(options={})
      url = "/user/#{@user_id}/apiSubscriptions"
      if options[:subscription_id]
        url += "/#{options[:subscription_id]}"
      end
      if options[:subscription_response_format]
        url += ".#{options[:subscription_response_format]}"
      else
        url += ".json"
      end
      # puts "Url: #{url}"
      # resp = post(url)
      # p resp
    end
    
    def create_food_subscription
      
    end
    
    def create_activity_subscription
      
    end
    
    def create_sleep_subscription
      
    end
    
    def create_body_subscription
      
    end
    
    def remove_subscription
      
    end
    
  end
end