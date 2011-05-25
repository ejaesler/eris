require 'spec_helper'

describe Eris::ProxiedRequest do

  let(:request) do
    Eris::ProxiedRequest.new({ "url" => "http://api.example.com", "body" => { "foo" => "bar", "baz" => "quux"}})
  end

  it "should build a command string for curl" do
    request.cmd_str.should match /^curl/
  end

  it "should use the correct URL" do
    request.cmd_str.should match /http:\/\/api\.example\.com/
  end

  it "should turn the params into query params" do
    request.cmd_str.should match /foo=bar/
    request.cmd_str.should match /baz=quux/
    request.cmd_str.should match /\?.*=.*&.*=.*/
  end
end