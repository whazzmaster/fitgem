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
  
  describe "data retrieval by time range" do
    
    it 'should format the correct URI fragment based on a base date and end date' do
      frag = @client.construct_date_range_fragment({:base_date => '2011-03-07', :end_date => '2011-03-14'})
      frag.should == 'date/2011-03-07/2011-03-14'
    end
    
    it 'should format the correct URI fragment based on a base date and period' do
      frag = @client.construct_date_range_fragment({:base_date => '2011-03-07', :period => '7d'})
      frag.should == 'date/2011-03-07/7d'
    end
    
    it 'should raise an error unless there is a base date AND either a period or an end date' do
      lambda {
        @client.construct_date_range_fragment({:base_date => '2011-03-07'})
      }.should raise_error(Fitbit::InvalidTimeRange)
      
      lambda {
        @client.construct_date_range_fragment({:period => '1y'})
      }.should raise_error(Fitbit::InvalidTimeRange)
      
      lambda {
        @client.construct_date_range_fragment({:end_date => '2011-03-07', :period => '7d'})
      }.should raise_error(Fitbit::InvalidTimeRange)
    end
    
  end
  
  describe "format_date" do
    it 'should accept DateTime objects' do
      date = DateTime.strptime('2011-03-19','%Y-%m-%d')
      @client.format_date(date).should == '2011-03-19'
    end
    
    it 'should accept strings in YYYY-MM-DD format' do
      @client.format_date('2011-03-19').should == '2011-03-19'
    end
  end
end