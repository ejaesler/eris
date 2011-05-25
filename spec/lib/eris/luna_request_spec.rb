require 'spec_helper'

describe LunaRequest do
  it "should populate the service correctly" do
    request = LunaRequest.new({ "url" => "com.palm.db", "body" => ["foo"]})

    request.cmd_str.should match(/-i com\.palm\.db/)
  end

  describe "param escaping" do
    it "should escape spaces properly" do
      request = LunaRequest.new({ "url" => "com.palm.db", "body" => ["foo bar"]})
      request.params.should == "[\"foo\\ bar\"]"
    end

    it "should escape single quotes properlyish?" do
      request = LunaRequest.new({ "url" => "com.palm.db", "body" => ["foo'bar"]})
      JSON.parse(`echo '#{request.params}'`).should == ["foo'bar"]
    end

    it "should escape new lines" do
      request = LunaRequest.new({ "url" => "com.palm.db", "body" => ['f\noo']})
      JSON.parse(`echo '#{request.params}'`).should == ['f\noo']
#      request.params.should == %{["foo\\nbar"]}
    end
  end
end