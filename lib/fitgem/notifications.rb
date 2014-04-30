module Fitgem
  class Client
    SUBSCRIBABLE_TYPES = [:sleep, :body, :activities, :foods, :all]

    # Get a list of all subscriptions
    #
    # @param [Hash] opts Subscription query data
    # @option opts [Integer, String] :type The type of subscription (valid
    #   values are :activities, :foods, :sleep, :body, and :all). REQUIRED
    #
    # @return [Hash] Hash contain subscription information
    # @since v0.4.0
    def subscriptions(opts)
      get make_subscription_url(opts), make_headers(opts)
    end

    # Creates a notification subscription
    #
    # @note You must check the HTTP response code to check the status of the request to add a subscription.  See {https://wiki.fitbit.com/display/API/Fitbit+Subscriptions+API} for information about what the codes mean.
    #
    # @param [Hash] opts The notification subscription data
    # @option opts [Symbol] :type The type of subscription (valid
    #   values are :activities, :foods, :sleep, :body, and :all). REQUIRED
    # @option opts [Integer, String] :subscriptionId The subscription id 
    #
    # @return [Integer, Hash] An array containing the HTTP response code and
    #   a hash containing confirmation information for the subscription.  
    # @since v0.4.0
    def create_subscription(opts)
      resp = raw_post make_subscription_url(opts.merge({:use_subscription_id => true})), EMPTY_BODY, make_headers(opts)
      [resp.code, extract_response_body(resp)]
    end

    # Removes a notification subscription
    #
    # @note You must check the HTTP response code to check the status of the request to remove a subscription.  See {https://wiki.fitbit.com/display/API/Fitbit+Subscriptions+API} for information about what the codes mean.
    #
    # @param [Hash] opts The notification subscription data
    # @option opts [Symbol] :type The type of subscription to remove;
    #   valid values are :activities, :foods, :sleep, :body, and :all).
    #   REQUIRED
    # @option opts [Integer, String] :subscription_id The id of the
    #   subscription to remove.
    # @option opts [Inteter, Stri)g] :subscriber_id The subscriber id of the client
    #   application, created via {http://dev.fitbit.com}
    #
    # @return [Integer, Hash] An array containing the HTTP response code and
    #   a hash containing confirmation information for the subscription.  
    # @since v0.4.0
    def remove_subscription(opts)
      resp = raw_delete make_subscription_url(opts.merge({:use_subscription_id => true})), make_headers(opts)
      [resp.code, extract_response_body(resp)]
    end

    protected

    # Ensures that the type supplied is valid
    #
    # @param [Symbol] subscription_type The type of subscription;
    #   valid values are (:sleep, :body, :activities, :foods, and
    #   :all)
    # @raise [Fitgem::InvalidArgumentError] Raised if the supplied type
    #   is not valid
    # @return [Boolean] 
    def validate_subscription_type(subscription_type)
      unless subscription_type && SUBSCRIBABLE_TYPES.include?(subscription_type)
        raise Fitgem::InvalidArgumentError, "Invalid subscription type (valid values are #{SUBSCRIBABLE_TYPES.join(', ')})"
      end
      true
    end

    # Create the headers hash for subscription management calls
    #
    # This method both adds approriate headers given what is in the
    # options hash, as well as removes extraneous hash entries that are
    # not needed in the headers of the request sent to the API.
    #
    # @param [Hash] opts The options for header creation
    # @option opts [String] :subscriber_id The subscriber id of the client
    #   application, created via {http://dev.fitbit.com}
    # @return [Hash] The headers has to pass to the get/post/put/delete
    #   methods
    def make_headers(opts)
      headers = {}
      if opts[:subscriber_id]
        headers['X-Fitbit-Subscriber-Id'] = opts[:subscriber_id]
      end
      headers
    end

    # Create the subscription management API url
    #
    # @param [Hash] opts The options on how to construct the
    #   subscription API url
    # @option opts [Symbol] :type The type of subscription;
    #   valid values are (:sleep, :body, :activities, :foods, and
    #   :all)
    # @option opts [Symbol] :use_subscription_id If true, then
    #   opts[:subscription_id] will be used in url construction
    # @option opts [String] :subscription_id The id of the subscription
    #   that the URL is for
    # @return [String] The url to use for subscription management
    def make_subscription_url(opts)
      validate_subscription_type opts[:type]
      path = if opts[:type] == :all
        ""
      else
        "/"+opts[:type].to_s
      end
      url = "/user/#{@user_id}#{path}/apiSubscriptions"
      if opts[:use_subscription_id]
        unless opts[:subscription_id]
          raise Fitgem::InvalidArgumentError, "Must include options[:subscription_id]"
        end
        url += "/#{opts[:subscription_id]}"
      end
      url += ".json"
    end
  end
end
