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

  describe "#format_time" do
    it "accepts DateTime objects" do
      time = DateTime.parse("3rd Feb 2001 04:05:06 PM")
      @client.format_time(time).should == "16:05"
    end

    it "accepts Time objects" do
      time = Time.mktime 2012, 1, 20, 13, 33, 30
      @client.format_time(time).should == "13:33"
    end

    it "accepts the string 'now' to denote the current localtime" do
      now = DateTime.now
      @client.format_time('now').should == now.strftime("%H:%M")
    end

    it "accepts strings in HH:mm format" do
      time = "04:20"
      @client.format_time(time).should == "04:20"
    end

    it "rejects Date objects" do
      date = Date.today
      expect {
        @client.format_time(date)
      }.to raise_error Fitgem::InvalidTimeArgument
    end

    it "rejects strings that are not in HH:mm format" do
      time = "4:20pm"
      expect {
        @client.format_time(time)
      }.to raise_error Fitgem::InvalidTimeArgument
    end

    it "rejects strings that are formatted correctly but include non-numeric elements" do
      time = "4a:33"
      expect {
        @client.format_time(time)
      }.to raise_error Fitgem::InvalidTimeArgument
    end

    it "rejects arguments that do not conform to accepted types" do
      expect {
        @client.format_time(200)
      }.to raise_error Fitgem::InvalidTimeArgument
    end
  end

  describe "#label_for_measurement" do
    it "accepts the supported Fitgem::ApiUnitSystem values" do
      @client.api_unit_system = Fitgem::ApiUnitSystem.US
      @client.label_for_measurement :duration, false
      @client.api_unit_system = Fitgem::ApiUnitSystem.UK
      @client.label_for_measurement :duration, false
      @client.api_unit_system = Fitgem::ApiUnitSystem.METRIC
      @client.label_for_measurement :duration, false
    end

    it "raises an InvalidUnitSystem error if the Fitgem::Client.api_unit_system value is invalid" do
      expect {
        @client.api_unit_system = "something else entirely"
        @client.label_for_measurement :duration, false
      }.to raise_error Fitgem::InvalidUnitSystem
    end

    it "accepts the supported values for the measurement_type parameter" do
      @client.label_for_measurement :duration, false
      @client.label_for_measurement :distance, false
      @client.label_for_measurement :elevation, false
      @client.label_for_measurement :height, false
      @client.label_for_measurement :weight, false
      @client.label_for_measurement :measurements, false
      @client.label_for_measurement :liquids, false
      @client.label_for_measurement :blood_glucose, false
    end

    it "raises an InvalidMeasurementType error if the measurement_type parameter is invalid" do
      expect {
        @client.label_for_measurement :homina, false
      }.to raise_error Fitgem::InvalidMeasurementType
    end

    it "returns the correct values when the unit system is Fitgem::ApiUnitSystem.US" do
      @client.api_unit_system = Fitgem::ApiUnitSystem.US
      @client.label_for_measurement(:duration, false).should == "milliseconds"
      @client.label_for_measurement(:distance, false).should == "miles"
      @client.label_for_measurement(:elevation, false).should == "feet"
      @client.label_for_measurement(:height, false).should == "inches"
      @client.label_for_measurement(:weight, false).should == "pounds"
      @client.label_for_measurement(:measurements, false).should == "inches"
      @client.label_for_measurement(:liquids, false).should == "fl oz"
      @client.label_for_measurement(:blood_glucose, false).should == "mg/dL"
    end

    it "returns the correct values when the unit system is Fitgem::ApiUnitSystem.UK" do
      @client.api_unit_system = Fitgem::ApiUnitSystem.UK
      @client.label_for_measurement(:duration, false).should == "milliseconds"
      @client.label_for_measurement(:distance, false).should == "kilometers"
      @client.label_for_measurement(:elevation, false).should == "meters"
      @client.label_for_measurement(:height, false).should == "centimeters"
      @client.label_for_measurement(:weight, false).should == "stone"
      @client.label_for_measurement(:measurements, false).should == "centimeters"
      @client.label_for_measurement(:liquids, false).should == "mL"
      @client.label_for_measurement(:blood_glucose, false).should == "mmol/l"
    end

    it "returns the correct values when the unit system is Fitgem::ApiUnitSystem.METRIC" do
      @client.api_unit_system = Fitgem::ApiUnitSystem.METRIC
      @client.label_for_measurement(:duration, false).should == "milliseconds"
      @client.label_for_measurement(:distance, false).should == "kilometers"
      @client.label_for_measurement(:elevation, false).should == "meters"
      @client.label_for_measurement(:height, false).should == "centimeters"
      @client.label_for_measurement(:weight, false).should == "kilograms"
      @client.label_for_measurement(:measurements, false).should == "centimeters"
      @client.label_for_measurement(:liquids, false).should == "mL"
      @client.label_for_measurement(:blood_glucose, false).should == "mmol/l"
    end

    context "when respecting the user's unit measurement preferences" do
      before(:each) do
        @client.stub(:connected?).and_return(true)
        @client.stub(:user_info).and_return({"user" => {"distanceUnit"=>"en_GB", "glucoseUnit"=>"en_GB", "heightUnit"=>"en_GB", "waterUnit"=>"METRIC", "weightUnit"=>"en_GB"}})
      end

      it "returns the correct overridden measurement label" do
        @client.api_unit_system = Fitgem::ApiUnitSystem.US
        @client.label_for_measurement(:distance).should == "kilometers"
      end
    end
  end
end
