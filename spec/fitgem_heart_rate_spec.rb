require 'spec_helper'

describe Fitgem::Client do
  before(:each) do
    @client = Fitgem::Client.new({
      :consumer_key => '12345',
      :consumer_secret => '67890'
    })
  end

  describe '#heart_rate' do
    it 'formats the correct URI based on a base date and period' do
      expect(@client).to receive(:get).with('/user/-/activities/heart/date/2015-09-27/30d.json')
      @client.heart_rate({:base_date => '2015-09-27', :period => '30d'})
    end

    it 'formats the correct URI based on a base date and end date' do
      expect(@client).to receive(:get).with('/user/-/activities/heart/date/2015-12-01/2015-12-28.json')
      @client.heart_rate({:base_date => '2015-12-01', :end_date => '2015-12-28'})
    end

    it 'raises an error when none of the required options are specified' do
      expect { @client.heart_rate({}) }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an error when date is specified' do
      expect { @client.heart_rate({:date => '2015-04-26'}) }.to raise_error(Fitgem::InvalidArgumentError)
    end
  end
end
