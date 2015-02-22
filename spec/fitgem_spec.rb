require 'spec_helper'

describe Fitgem do
  before do
    @client = Fitgem::Client.new({
      :consumer_key => '12345',
      :consumer_secret => '67890'
    })
  end

  describe 'global settings' do
    it 'should expose the api_version' do
      expect(@client.api_version).to eq "1"
    end

    it 'should all clients to set a new api version' do
      @client.api_version = "2"
      expect(@client.api_version).to eq "2"
    end

    it 'should default to the US unit system' do
      expect(@client.api_unit_system).to eq Fitgem::ApiUnitSystem.US
    end

    it 'should allow the unit system to be set to other types' do
      @client.api_unit_system = Fitgem::ApiUnitSystem.UK
      expect(@client.api_unit_system).to eq Fitgem::ApiUnitSystem.UK
      @client.api_unit_system = Fitgem::ApiUnitSystem.METRIC
      expect(@client.api_unit_system).to eq Fitgem::ApiUnitSystem.METRIC
    end

    it 'should default to a user id of \'-\', the currently-logged in user' do
      expect(@client.user_id).to eq '-'
    end
  end

  describe '#reconnect' do
    it 'resets the access token' do
      access_token = @client.reconnect('abc', '123')
      expect(access_token.token).to eq('abc')
      expect(access_token.secret).to eq('123')

      access_token = @client.reconnect('def', '456')
      expect(access_token.token).to eq('def')
      expect(access_token.secret).to eq('456')
    end
  end
end
