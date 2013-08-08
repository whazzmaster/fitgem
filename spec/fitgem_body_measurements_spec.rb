require 'spec_helper'

describe Fitgem::Client do
  before(:each) do
    @client = Fitgem::Client.new({
      :consumer_key => '12345',
      :consumer_secret => '67890'
    })
  end

  describe "#body_weight" do
    it "formats the correct URI based on a date" do
      @client.should_receive(:get).with("/user/-/body/log/weight/date/2013-04-26.json")
      @client.body_weight({:date => "2013-04-26"})
    end

    it "formats the correct URI based on a base date and period" do
      @client.should_receive(:get).with("/user/-/body/log/weight/date/2013-09-27/30d.json")
      @client.body_weight({:base_date => "2013-09-27", :period => "30d"})
    end

    it "formats the correct URI based on a base date and end date" do
      @client.should_receive(:get).with("/user/-/body/log/weight/date/2013-12-01/2013-12-28.json")
      @client.body_weight({:base_date => "2013-12-01", :end_date => "2013-12-28"})
    end

    it "raises an error when none of the required options are specified" do
      expect { @client.body_weight({}) }.to raise_error(Fitgem::InvalidArgumentError)
    end
  end

  describe "#body_fat" do
    it "formats the correct URI based on a date" do
      @client.should_receive(:get).with("/user/-/body/log/fat/date/2013-04-26.json")
      @client.body_fat({:date => "2013-04-26"})
    end

    it "formats the correct URI based on a base date and period" do
      @client.should_receive(:get).with("/user/-/body/log/fat/date/2013-09-27/30d.json")
      @client.body_fat({:base_date => "2013-09-27", :period => "30d"})
    end

    it "formats the correct URI based on a base date and end date" do
      @client.should_receive(:get).with("/user/-/body/log/fat/date/2013-12-01/2013-12-28.json")
      @client.body_fat({:base_date => "2013-12-01", :end_date => "2013-12-28"})
    end

    it "raises an error when none of the required options are specified" do
      expect { @client.body_fat({}) }.to raise_error(Fitgem::InvalidArgumentError)
    end
  end
end
