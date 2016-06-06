require 'spec_helper'

RSpec.describe Fitgem::Client do
  let(:access_token) {
    double 'Access Token', :get => response, :request => response
  }
  let(:consumer_key) { '12345' }
  let(:consumer_secret) { '67890' }
  let(:client)       { Fitgem::Client.new({
    :consumer_key => consumer_key,
    :consumer_secret => consumer_secret
  }) }
  let(:response)     { double :body => {:foo => :bar}.to_json, :status => 200 }
  let(:consumer)     { double 'Consumer' }
  let(:redirect_uri) { 'http://example.com/redirect_url' }
  let(:auth_url) { 'http://example.com/auth_url' }
  let(:auth_code) { 'code' }
  let(:scope) { 'activity nutrition heartrate location nutrition profile settings sleep social weight' }
  let(:auth_header) {
    {
        Authorization: "Basic #{Base64.encode64("#{consumer_key}:#{consumer_secret}")}"
    }
  }
  let(:auth_token) { 'token' }

  before :each do
    allow(OAuth2::Client).to receive(:new).with('12345', '67890', {
      :site          => "https://api.fitbit.com",
      :token_url     => "https://api.fitbit.com/oauth2/token",
      :authorize_url => "https://www.fitbit.com/oauth2/authorize"
    }).and_return(consumer)
    allow(OAuth2::AccessToken).to receive(:new).and_return(access_token)

    allow(consumer).to receive_message_chain('auth_code.authorize_url').
        with({scope: scope, redirect_uri: redirect_uri}).and_return(auth_url)
    allow(consumer).to receive_message_chain('auth_code.get_token').
        with(auth_code, {headers: auth_header, redirect_uri: redirect_uri}).and_return(auth_token)
  end

  it 'get authorize url' do
    expect(client.authorize_url(scope, redirect_uri)).to eq auth_url
  end

  it 'get token'do
    expect(client.get_token(auth_code, redirect_uri)).to eq auth_token
  end

  it 'returns JSON from the request' do
    expect(client.user_info).to eq({'foo' => 'bar'})
  end

  it 'raises a service unavailable exception when the status is 503' do
    allow(response).to receive(:status).and_return(503)

    expect { client.user_info }.to raise_error(Fitgem::ServiceUnavailableError)
  end

  context "response with an blank body" do
    let(:response) { double :body => "", :status => 200 }

    it "is properly parsed" do
      blank_user_info = client.user_info
      expect(blank_user_info).to eq({})
    end
  end
end
