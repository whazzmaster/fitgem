require 'fitgem/version'
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

    # Sets or gets the api_version to be used in API calls
    #
    # @return [String]
    attr_accessor :api_version

    # Sets or gets the api unit system to be used in API calls
    #
    # @return [String]
    #
    # @example Set this using the {Fitgem::ApiUnitSystem}
    #   client.api_unit_system = Fitgem::ApiUnitSystem.UK
    attr_accessor :api_unit_system

    # Sets or gets the user id to be used in API calls
    #
    # @return [String]
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
        @consumer ||= OAuth::Consumer.new(@consumer_key, @consumer_secret, { 
          :site => 'http://api.fitbit.com', 
          :proxy => @proxy
        })
      end

      def access_token
        @access_token ||= OAuth::AccessToken.new(consumer, @token, @secret)
      end

      def get(path, headers={})
        headers.merge!("User-Agent" => "fitgem gem v#{Fitgem::VERSION}", "Accept-Language" => @api_unit_system)
        uri = "/#{@api_version}#{path}"
        oauth_response = access_token.get(uri, headers)
        process_response oauth_response
      end

      def post(path, body='', headers={})
        headers.merge!("User-Agent" => "fitgem gem v#{Fitgem::VERSION}", "Accept-Language" => @api_unit_system)
        uri = "/#{@api_version}#{path}"
        oauth_response = access_token.post(uri, body, headers)
        process_response oauth_response
      end

      def delete(path, headers={})
        headers.merge!("User-Agent" => "fitgem gem v#{Fitgem::VERSION}", "Accept-Language" => @api_unit_system)
        uri = "/#{@api_version}#{path}"
        oauth_response = access_token.delete(uri, headers)
        process_response oauth_response
      end

      def process_response(resp)
        resp.nil? || resp.body.nil? ? {} : JSON.parse(resp.body)
      end
  end
end
