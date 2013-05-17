require 'spec_helper'

describe Fitgem::Client do
  before do
    @client = Fitgem::Client.new({
      :consumer_key => '12345',
      :consumer_secret => '67890'
    })
  end

  describe '#intraday_time_series' do
    before(:each) do
      @date_opts = {
          resource: :calories,
          date: '2013-05-13',
          detailLevel: '1min'
      }
      @time_opts = {
          resource: :calories,
          date: '2013-05-13',
          detailLevel: '15min',
          startTime: '10:00',
          endTime: '13:00'
      }
    end

    it 'raises an exception if the resource is missing' do
      expect {
        @client.intraday_time_series(@date_opts.merge!(resource: nil))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the resource is not valid' do
      expect {
        @client.intraday_time_series(@date_opts.merge!(resource: :some_wrong_thing))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the date is missing' do
      expect {
        @client.intraday_time_series(@date_opts.merge!(date: nil))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the date is invalid' do
      expect {
        @client.intraday_time_series(@date_opts.merge!(date: 'zach-is-cool'))
      }.to raise_error(Fitgem::InvalidDateArgument)
    end

    it 'raises an exception if the detail level is missing' do
      expect {
        @client.intraday_time_series(@date_opts.merge!(detailLevel: nil))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the detail level is invalid' do
      expect {
        @client.intraday_time_series(@date_opts.merge!(detailLevel: '5years'))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if only the start time is supplied' do
      expect {
        @client.intraday_time_series(@time_opts.merge!(endTime: nil))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if only the end time is supplied' do
      expect {
        @client.intraday_time_series(@time_opts.merge!(startTime: nil))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the start time is invalid' do
      expect {
        @client.intraday_time_series(@time_opts.merge!(startTime: 'what-is-this-nonsense'))
      }.to raise_error(Fitgem::InvalidTimeArgument)
    end

    it 'raises an exception if the end time is invalid' do
      expect {
        @client.intraday_time_series(@time_opts.merge!(endTime: 'what-is-this-nonsense'))
      }.to raise_error(Fitgem::InvalidTimeArgument)
    end

    it 'constructs the correct time-based url' do
      @client.should_receive(:get).with('/user/-/activities/calories/date/2013-05-13/1d/15min/time/10:00/13:00.json', {})
      @client.intraday_time_series(@time_opts)
    end

    it 'constructs the correct date-based url' do
      @client.should_receive(:get).with('/user/-/activities/calories/date/2013-05-13/1d/1min.json', {})
      @client.intraday_time_series(@date_opts)
    end
  end
end