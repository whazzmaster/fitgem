module Fitgem
  class Client
    
    def create_subscription(options={})
      unless options[:type] && [:sleep,:body,:activities,:foods].include?(options[:type])
        raise Error, 'Must include options[:type] (values are :activities, :foods, :sleep, and :body)'
      end
      base_url = "/user/#{@user_id}/#{options[:type].to_s}/apiSubscriptions"
      post_subscription(base_url, options)
    end
    
    def remove_subscription(options={})
      unless options[:type] && [:sleep,:body,:activities,:foods].include?(options[:type])
        raise Error, 'Must include options[:type] (values are :activities, :foods, :sleep, and :body)'
      end
      unless options[:subscription_id]
        raise Error, "Must include options[:subscription_id] to delete a subscription"
      end
      base_url = "/user/#{@user_id}/#{options[:type].to_s}/apiSubscriptions"
      url = finalize_subscription_url(base_url, options)
      headers = {}
      headers['X-Fitgem-Subscriber-Id'] = options[:subscriber_id] if options[:subscriber_id]
      begin
        delete(url, headers)
      rescue TypeError
        # Deleting a subscription returns a nil response, which causes a TypeError
        # when the oauth library tries to parse it.
      end
    end
    
    protected
    
    def finalize_subscription_url(base_url, options={})
      url = base_url
      if options[:subscription_id]
        url += "/#{options[:subscription_id]}"
      end
      if options[:subscription_response_format]
        url += ".#{options[:subscription_response_format]}"
      else
        url += ".json"
      end
      url
    end
    
    def post_subscription(base_url, options)
      url = finalize_subscription_url(base_url, options)
      post(url, options)
    end
    
  end
end