require 'spec_helper'

describe Fitgem::Client do
  before do
    @client = Fitgem::Client.new({
      :consumer_key => '12345',
      :consumer_secret => '67890'
    })
  end

  describe '#create_or_update_daily_goal' do
    before(:each) do
      @opts = {type: :steps, value: '10000'}
    end

    it 'raises an exception if the :type value is missing' do
      @opts.delete :type
      expect {
        @client.create_or_update_daily_goal @opts
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the :type value is not valid' do
      @opts[:type] = :milesWalked
      expect {
        @client.create_or_update_daily_goal @opts
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the :value value is missing' do
      @opts.delete :value
      expect {
        @client.create_or_update_daily_goal @opts
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'posts to the correct URI if the :type and :value are valid' do
      expect(@client).to receive(:post).with('/user/-/activities/goals/daily.json', @opts)
      @client.create_or_update_daily_goal @opts
    end
  end

  describe '#create_or_update_weekly_goal' do
    before(:each) do
      @opts = { type: :steps, value: '10000' }
    end

    it 'raises an exception if the :type value is missing' do
      @opts.delete :type
      expect {
        @client.create_or_update_weekly_goal @opts
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the :type value is not valid' do
      @opts[:type] = :milesWalked
      expect {
        @client.create_or_update_weekly_goal @opts
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the :value value is missing' do
      @opts.delete :value
      expect {
        @client.create_or_update_weekly_goal @opts
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'posts to the correct URI if the :type and :value are valid' do
      expect(@client).to receive(:post).with('/user/-/activities/goals/weekly.json', @opts)
      @client.create_or_update_weekly_goal @opts
    end
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
      @date_range_opts = {
          resource: :calories,
          detailLevel: '15min',
          start_date: '2013-05-13',
          end_date: '2014-05-13'
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

    it 'valid resources should not raise an error' do
      allow(@client).to receive(:raw_get)
      [:calories, :steps, :distance, :floors, :elevation].each do |resource|
        opts = { resource: resource, date: '2013-05-13', detailLevel: '15min' }
        expect{
          @client.intraday_time_series(opts)
        }.not_to raise_error
      end
    end

    it 'raises an exception if the date is missing' do
      expect {
        @client.intraday_time_series(@date_opts.merge!(date: nil))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the date is missing and either start_date or end_date is missing' do
      expect {
        @client.intraday_time_series(@date_range_opts.merge!(start_date: nil))
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

    it 'raises an exception if only the start date is supplied' do
      expect {
        @client.intraday_time_series(@date_range_opts.merge!(end_date: nil))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if only the end date is supplied' do
      expect {
        @client.intraday_time_series(@date_range_opts.merge!(start_date: nil))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the end date is invalid' do
      expect {
        @client.intraday_time_series(@date_range_opts.merge!(end_date: 'what-is-this-nonsense'))
      }.to raise_error(Fitgem::InvalidArgumentError)
    end

    it 'raises an exception if the start date is invalid' do
      expect {
        @client.intraday_time_series(@date_range_opts.merge!(start_date: 'what-is-this-nonsense'))
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
      expect(@client).to receive(:get).with('/user/-/activities/calories/date/2013-05-13/1d/15min/time/10:00/13:00.json', {})
      @client.intraday_time_series(@time_opts)
    end

    it 'constructs the correct date-based url' do
      expect(@client).to receive(:get).with('/user/-/activities/calories/date/2013-05-13/1d/1min.json', {})
      @client.intraday_time_series(@date_opts)
    end

    it 'constructs the correct date-range-based url' do
      expect(@client).to receive(:get).with('/user/-/activities/calories/date/2013-05-13/2014-05-13.json', {})
      @client.intraday_time_series(@date_range_opts)
    end
  end
end
