require 'spec_helper'

describe Eris::ProxiedRequest do

  let(:request) do
    Eris::ProxiedRequest.new({ "url" => "http://api.example.com", "body" => { "foo" => "bar", "baz" => "quux corge"}})
  end


  it "should use the correct URL" do
    request.url.should match /http:\/\/api\.example\.com/
  end

  it "should turn the params into query params, including escaping" do
    request.url.should match /foo=bar/
    request.url.should match /baz=quux%20corge/
    request.url.should match /\?.*=.*&.*=.*/
  end
end