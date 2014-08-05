require 'spec_helper'
require 'ostruct'

describe Fitgem::Client do
  before(:each) do
    @client = Fitgem::Client.new({:consumer_key => '12345', :consumer_secret => '56789'})
  end

  describe "#subscriptions" do
    before(:each) do
      allow(@client).to receive(:get)
    end

    it "calls #make_headers to create the headers for the API call" do
      opts = { :subscriber_id => "5555", :type => :all }
      expect(@client).to receive(:make_headers).with({:type=>:all, :subscriber_id=>"5555"})
      @client.subscriptions(opts)
    end

    it "calls #get with the correct url and headers" do
      opts = { :subscriber_id => "5555", :type => :all }
      expect(@client).to receive(:get).with("/user/-/apiSubscriptions.json", {"X-Fitbit-Subscriber-Id"=>"5555"})
      @client.subscriptions(opts)
    end
  end

  describe "#create_subscription" do
    before(:each) do
      @resp = OpenStruct.new
      allow(@client).to receive(:raw_post).and_return(@resp)
    end

    it "adds the :use_subscription_id flag and calls #make_headers" do
      opts = { :subscriber_id => "5555", :type => :all, :subscription_id => "320" }
      expect(@client).to receive(:make_headers).with({ :subscriber_id => "5555", :type => :all, :subscription_id => "320"})
      @client.create_subscription(opts)
    end

    it "calls #raw_post with the correct url and headers for :all collection type" do
      opts = { :subscriber_id => "5555", :type => :all, :subscription_id => "320", :use_subscription_id => true }
      expect(@client).to receive(:raw_post).once.with("/user/-/apiSubscriptions/320.json", "", {"X-Fitbit-Subscriber-Id"=>"5555"})
      @client.create_subscription(opts)
    end

    it "calls #raw_post with the correct url and headers for :sleep collection type" do
      opts = { :subscriber_id => "5555", :type => :sleep, :subscription_id => "320", :use_subscription_id => true }
      expect(@client).to receive(:raw_post).once.with("/user/-/sleep/apiSubscriptions/320.json", "", {"X-Fitbit-Subscriber-Id"=>"5555"})
      @client.create_subscription(opts)
    end

    it "calls #extract_response_body to get the JSON body" do
      opts = { :subscriber_id => "5555", :type => :all, :subscription_id => "320", :use_subscription_id => true }
      expect(@client).to receive(:extract_response_body)
      @client.create_subscription(opts)
    end

    it "returns the code and the JSON body in an array" do
      opts = { :subscriber_id => "5555", :type => :all, :subscription_id => "320", :use_subscription_id => true }
      expect(@resp).to receive(:code)
      expect(@client.create_subscription(opts)).to be_a(Array)
    end
  end

  describe "#remove_subscription" do
    before(:each) do
      @resp = OpenStruct.new
      allow(@client).to receive(:raw_delete).and_return(@resp)
    end

    it "adds the :use_subscription_id flag and calls #make_headers" do
      opts = { :subscriber_id => "5555", :type => :all, :subscription_id => "320" }
      expect(@client).to receive(:make_headers).with({ :subscriber_id => "5555", :type => :all, :subscription_id => "320" })
      @client.remove_subscription(opts)
    end

    it "calls #raw_delete with the correct url and headers for :all collection type" do
      opts = { :subscriber_id => "5555", :type => :all, :subscription_id => "320", :use_subscription_id => true }
      expect(@client).to receive(:raw_delete).once.with("/user/-/apiSubscriptions/320.json", {"X-Fitbit-Subscriber-Id"=>"5555"})
      @client.remove_subscription(opts)
    end

    it "calls #extract_response_body to get the JSON body" do
      opts = { :subscriber_id => "5555", :type => :all, :subscription_id => "320", :use_subscription_id => true }
      expect(@client).to receive(:extract_response_body)
      @client.remove_subscription(opts)
    end

    it "returns the code and the JSON body in an array" do
      opts = { :subscriber_id => "5555", :type => :all, :subscription_id => "320", :use_subscription_id => true }
      expect(@resp).to receive(:code)
      expect(@client.remove_subscription(opts)).to be_a(Array)
    end
  end

  describe "#validate_subscription_types" do
    it "raises an exception if an invalid type is passed in" do
      expect {
        @client.send(:validate_subscription_type, :every_single_thing)
      }.to raise_error Fitgem::InvalidArgumentError, "Invalid subscription type (valid values are sleep, body, activities, foods, all)"
    end

    it "raises an exception if no type is supplied" do
      opts = { :opt1 => 'hello!' }
      expect {
        @client.send(:validate_subscription_type, opts[:type])
      }.to raise_error Fitgem::InvalidArgumentError
    end
  end

  describe "#make_headers" do
    it "adds the subscriber id header" do
      opts = { :subscriber_id => '5555', :subscription_id => '320-activity' }
      headers = @client.send(:make_headers, opts)
      expect(headers.size).to eq 1
      expect(headers['X-Fitbit-Subscriber-Id']).to eq "5555"
    end
  end

  describe "#make_subscription_url" do
    it "creates the correct URL when no specific subscription id is used" do
      opts = { :subscription_id => "320", :type => :all }
      expect(@client.send(:make_subscription_url, opts)).to eq "/user/-/apiSubscriptions.json"
    end

    it "creates the correct URL for :all collection types" do
      opts = { :subscription_id => "320", :type => :all, :use_subscription_id => true }
      expect(@client.send(:make_subscription_url, opts)).to eq "/user/-/apiSubscriptions/320.json"
    end

    it "creates the correct URL for the :sleep collection type" do
      opts = { :subscription_id => "320", :type => :sleep, :use_subscription_id => true }
      expect(@client.send(:make_subscription_url, opts)).to eq "/user/-/sleep/apiSubscriptions/320.json"
    end

    it "creates the correct URL for the :body collection type" do
      opts = { :subscription_id => "320", :type => :body, :use_subscription_id => true }
      expect(@client.send(:make_subscription_url, opts)).to eq "/user/-/body/apiSubscriptions/320.json"
    end

    it "creates the correct URL for the :activities collection type" do
      opts = { :subscription_id => "320", :type => :activities, :use_subscription_id => true }
      expect(@client.send(:make_subscription_url, opts)).to eq "/user/-/activities/apiSubscriptions/320.json"
    end

    it "creates the correct URL for the :foods collection type" do
      opts = { :subscription_id => "320", :type => :foods, :use_subscription_id => true }
      expect(@client.send(:make_subscription_url, opts)).to eq "/user/-/foods/apiSubscriptions/320.json"
    end

    it "validates the supplied subscription type" do
      opts = { :subscription_id => "320" }
      expect { @client.send(:make_subscription_url, opts) }.to raise_error Fitgem::InvalidArgumentError

      opts[:type] = nil
      expect { @client.send(:make_subscription_url, opts) }.to raise_error Fitgem::InvalidArgumentError

      opts[:type] = :all
      expect { @client.send(:make_subscription_url, opts) }.not_to raise_error

      opts[:type] = :activities
      expect { @client.send(:make_subscription_url, opts) }.not_to raise_error

      opts[:type] = :sleep
      expect { @client.send(:make_subscription_url, opts) }.not_to raise_error

      opts[:type] = :foods
      expect { @client.send(:make_subscription_url, opts) }.not_to raise_error

      opts[:type] = :body
      expect { @client.send(:make_subscription_url, opts) }.not_to raise_error
    end
  end
end
