require 'spec_helper'

describe Fitbit do
  
  before do
    @client = Fitbit::Client.new
  end
  
  describe "global settings" do
    it 'should expose the api_version' do
      @client.api_version.should == "1"
    end
  
    it 'should all clients to set a new api version' do
      @client.api_version = "2"
      @client.api_version.should == "2"
    end
  
    it 'should default to the US unit system' do
      @client.api_unit_system.should == Fitbit::ApiUnitSystem.US
    end
  
    it 'should allow the unit system to be set to other types' do
      @client.api_unit_system = Fitbit::ApiUnitSystem.UK
      @client.api_unit_system.should == Fitbit::ApiUnitSystem.UK
      @client.api_unit_system = Fitbit::ApiUnitSystem.METRIC
      @client.api_unit_system.should == Fitbit::ApiUnitSystem.METRIC    
    end
  end
  
  describe "error conditions" do
    it 'should raise an error when passed an invalid date format' do
      lambda { @client.activities_on_date('fake_user', '2011-03-18') }.should raise_error(Fitbit::InvalidArgumentError)
    end
  end
end