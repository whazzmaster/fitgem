require 'spec_helper'

describe Fitgem::Client do
  before(:each) do
    @client = Fitgem::Client.new({
      :consumer_key => '12345',
      :consumer_secret => '67890'
    })
  end

  describe "#construct_date_range_fragment" do
    it 'should format the correct URI fragment based on a base date and end date' do
      frag = @client.construct_date_range_fragment({:base_date => '2011-03-07', :end_date => '2011-03-14'})
      frag.should == 'date/2011-03-07/2011-03-14'
    end

    it 'should format the correct URI fragment based on a base date and period' do
      frag = @client.construct_date_range_fragment({:base_date => '2011-03-07', :period => '7d'})
      frag.should == 'date/2011-03-07/7d'
    end

    it 'should raise an error unless there is a base date AND either a period or an end date' do
      expect {
        @client.construct_date_range_fragment({:base_date => '2011-03-07'})
      }.to raise_error(Fitgem::InvalidTimeRange)

      expect {
        @client.construct_date_range_fragment({:period => '1y'})
      }.to raise_error(Fitgem::InvalidTimeRange)

      expect {
        @client.construct_date_range_fragment({:end_date => '2011-03-07', :period => '7d'})
      }.to raise_error(Fitgem::InvalidTimeRange)
    end
  end

  describe "#format_date" do
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

    it "rejects strings that are not in YYY-MM-DD format" do
      date = "2011-3-2"
      expect {
        @client.format_date(date)
      }.to raise_error Fitgem::InvalidDateArgument, "Invalid date (2011-3-2), must be in yyyy-MM-dd format" 
    end

    it "rejects strings are formatted correctly but include non-numeric elements" do
      date = "2011-aa-20"
      expect {
        @client.format_date(date)
      }.to raise_error Fitgem::InvalidDateArgument, "Invalid date (2011-aa-20), must be in yyyy-MM-dd format"
    end

    it "rejects arguments that are not a Date, Time, DateTime, or String" do
      date = 200
      expect {
        @client.format_date(date)
      }.to raise_error Fitgem::InvalidDateArgument, "Date used must be a date/time object or a string in the format YYYY-MM-DD; supplied argument is a Fixnum"
    end
  end 
end
