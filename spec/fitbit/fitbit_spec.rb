require 'spec_helper'

describe Fitbit do
  
  it 'should expose the api_version' do
    Fitbit::Client.api_version.should == "1"
  end
  
end