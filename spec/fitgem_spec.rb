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
      @client.api_version.should == "1"
    end

    it 'should all clients to set a new api version' do
      @client.api_version = "2"
      @client.api_version.should == "2"
    end

    it 'should default to the US unit system' do
      @client.api_unit_system.should == Fitgem::ApiUnitSystem.US
    end

    it 'should allow the unit system to be set to other types' do
      @client.api_unit_system = Fitgem::ApiUnitSystem.UK
      @client.api_unit_system.should == Fitgem::ApiUnitSystem.UK
      @client.api_unit_system = Fitgem::ApiUnitSystem.METRIC
      @client.api_unit_system.should == Fitgem::ApiUnitSystem.METRIC
    end

    it 'should default to a user id of \'-\', the currently-logged in user' do
      @client.user_id.should == '-'
    end
  end
end
