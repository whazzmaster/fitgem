require 'spec_helper'

RSpec.describe Fitgem::Client do
  let(:access_token) { double 'Access Token', :get => response }
  let(:client)       { Fitgem::Client.new({
    :consumer_key => '12345',
    :consumer_secret => '67890'
  }) }
  let(:response)     {
    double :body => {:foo => :bar}.to_json,
           :code => 200,
           :headers => {'header_name_1' => 'header_value_1'}
  }
  let(:consumer)     { double 'Consumer' }

  before :each do
    allow(OAuth::Consumer).to receive(:new).with('12345', '67890',
                                {:site          => "https://api.fitbit.com",
                                 :authorize_url => "https://www.fitbit.com/oauth/authorize",
                                 :proxy         => nil}).and_return(consumer)
    allow(OAuth::AccessToken).to receive(:new).and_return(access_token)

    allow(client).to receive(:extract_response_headers).with(response).
                       and_return(response.headers)
  end

  it 'returns JSON body and headers from the request' do
    expected_result = {
      'foo' => 'bar',
      'http_headers' => { 'header_name_1' => 'header_value_1' }
    }
    expect(client.user_info).to eq(expected_result)
  end

  it 'raises a service unavailable exception when the status is 503' do
    allow(response).to receive(:code).and_return('503')

    expect { client.user_info }.to raise_error(Fitgem::ServiceUnavailableError)
  end
end
