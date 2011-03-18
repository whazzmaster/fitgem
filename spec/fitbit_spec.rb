require 'spec_helper'

describe Fitbit do
  
  before do
    @client = Fitbit::Client.new
  end
  
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