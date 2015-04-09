require 'spec_helper'

RSpec.describe Fitgem::Client do
  let(:access_token) { double 'Access Token', :get => response }
  let(:client)       { Fitgem::Client.new({
    :consumer_key => '12345',
    :consumer_secret => '67890'
  }) }
  let(:response)     { double :body => {:foo => :bar}.to_json, :code => 200 }

  before :each do
    allow(OAuth::AccessToken).to receive(:new).and_return(access_token)
  end

  it 'returns JSON from the request' do
    expect(client.user_info).to eq({'foo' => 'bar'})
  end

  it 'raises a service unavailable exception when the status is 503' do
    allow(response).to receive(:code).and_return('503')

    expect { client.user_info }.to raise_error(Fitgem::ServiceUnavailableError)
  end
end
