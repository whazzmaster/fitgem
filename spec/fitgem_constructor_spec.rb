require 'spec_helper'

describe Fitgem::Client do
  describe "constructor" do
    it "requires consumer_key" do
      expect {
        opts = { :consumer_secret => "12345" }
        client = Fitgem::Client.new(opts)
      }.to raise_error(Fitgem::InvalidArgumentError, "Missing required options: consumer_key")
    end

    it "requires consumer_secret" do
      expect {
        opts = { :consumer_key => "12345" }
        client = Fitgem::Client.new(opts)
      }.to raise_error(Fitgem::InvalidArgumentError, "Missing required options: consumer_secret")
    end
  end
end
