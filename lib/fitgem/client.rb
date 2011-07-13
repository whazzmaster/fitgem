require 'fitgem/helpers'
require 'fitgem/errors'
require 'fitgem/users'
require 'fitgem/activities'
require 'fitgem/sleep'
require 'fitgem/water'
require 'fitgem/units'
require 'fitgem/foods'
require 'fitgem/friends'
require 'fitgem/body_measurements'
require 'fitgem/time_range'
require 'fitgem/devices'
require 'fitgem/notifications'
require 'date'
require 'uri'

module Fitgem
  class Client

    attr_accessor :api_version
    attr_accessor :api_unit_system
    attr_accessor :user_id

    def initialize(options = {})
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @token = options[:token]
      @secret = options[:secret]
      @proxy = options[:proxy]
      @user_id = options[:user_id] || "-"
      @api_unit_system = Fitgem::ApiUnitSystem.US
      @api_version = "1"
    end

    def authorize(token, secret, options = {})
      request_token = OAuth::RequestToken.new(
        consumer, token, secret
      )
      @access_token = request_token.get_access_token(options)
      @token = @access_token.token
      @secret = @access_token.secret
      @access_token
    end

    def reconnect(token, secret)
      @token = token
      @secret = secret
      access_token
    end

    def request_token(options={})
      consumer.get_request_token(options)
    end

    def authentication_request_token(options={})
      consumer.options[:authorize_path] = '/oauth/authenticate'
      request_token(options)
    end

    private

      def consumer
        @consumer ||= OAuth::Consumer.new(
          @consumer_key,
          @consumer_secret,
          { :site => 'http://api.fitbit.com', :request_endpoint => @proxy }
        )
      end

      def access_token
        @access_token ||= OAuth::AccessToken.new(consumer, @token, @secret)
      end

      def get(path, headers={})
        headers.merge!("User-Agent" => "fitgem gem v#{Fitgem::VERSION}", "Accept-Language" => @api_unit_system)
        oauth_response = access_token.get("/#{@api_version}#{path}", headers)
        JSON.parse(oauth_response.body)
      end

      def post(path, body='', headers={})
        headers.merge!("User-Agent" => "fitgem gem v#{Fitgem::VERSION}", "Accept-Language" => @api_unit_system)
        oauth_response = access_token.post("/#{@api_version}#{path}", body, headers)
        JSON.parse(oauth_response.body)
      end

      def delete(path, headers={})
        p path
        p headers
        headers.merge!("User-Agent" => "fitgem gem v#{Fitgem::VERSION}", "Accept-Language" => @api_unit_system)
        oauth_response = access_token.delete("/#{@api_version}#{path}", headers)
        JSON.parse(oauth_response.body)
      end
  end
end