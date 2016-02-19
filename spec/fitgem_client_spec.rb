require 'spec_helper'

RSpec.describe Fitgem::Client do
  let(:access_token) {
    double 'Access Token', :get => response, :request => response
  }
  let(:client)       { Fitgem::Client.new({
    :consumer_key => '12345',
    :consumer_secret => '67890'
  }) }
  let(:response)     { double :body => {:foo => :bar}.to_json, :status => 200 }
  let(:consumer)     { double 'Consumer' }

  before :each do
    allow(OAuth2::Client).to receive(:new).with('12345', '67890', {
      :site          => "https://api.fitbit.com",
      :token_url     => "https://api.fitbit.com/oauth2/token",
      :authorize_url => "https://www.fitbit.com/oauth2/authorize"
    }).and_return(consumer)
    allow(OAuth2::AccessToken).to receive(:new).and_return(access_token)
  end

  it 'returns JSON from the request' do
    expect(client.user_info).to eq({'foo' => 'bar'})
  end

  it 'raises a service unavailable exception when the status is 503' do
    allow(response).to receive(:status).and_return(503)

    expect { client.user_info }.to raise_error(Fitgem::ServiceUnavailableError)
  end
end
