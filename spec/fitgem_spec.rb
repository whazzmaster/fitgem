require 'spec_helper'

describe Fitgem do

  before do
    @client = Fitgem::Client.new
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
      }.should raise_error(Fitgem::InvalidTimeRange)

      lambda {
        @client.construct_date_range_fragment({:period => '1y'})
      }.should raise_error(Fitgem::InvalidTimeRange)

      lambda {
        @client.construct_date_range_fragment({:end_date => '2011-03-07', :period => '7d'})
      }.should raise_error(Fitgem::InvalidTimeRange)
    end

  end

  describe "format_date" do
    it "accepts DateTime objects" do
      date = DateTime.strptime('2011-03-19','%Y-%m-%d')
      @client.format_date(date).should == '2011-03-19'
    end

    it "accepts strings in YYYY-MM-DD format" do
      @client.format_date('2011-03-19').should == '2011-03-19'
    end

    it "accepts the string 'today' to denote the current date" do
      today = Date.today.strftime("%Y-%m-%d")
      @client.format_date('today').should == today
    end

    it "accepts the string 'yesterday' to denote the day previous to today" do
      yesterday = (Date.today-1).strftime("%Y-%m-%d")
      @client.format_date('yesterday').should == yesterday
    end
  end
end