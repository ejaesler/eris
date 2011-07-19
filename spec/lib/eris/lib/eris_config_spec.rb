require 'spec_helper'

describe "Eris Config" do
  before do
    @app_root= File.join(File.dirname(__FILE__), '..', '..', '..', 'fixtures', 'sample_app')
    @config_path = File.join(@app_root, 'eris_config.json')
  end

  it 'should be able to read a config' do
    config = ErisConfig.new(:config_path => @config_path, :app_root => @app_root)
    config.enyo_root.should == File.join(@app_root, '../')
  end
  
  it "should not append the app_root path if an absolute path is given" do
    File.stub!(:read).and_return('{"enyoRoot": "/foo/bar" }')
    config = ErisConfig.new(:config_path => @config_path, :app_root => @app_root)
    config.enyo_root.should == '/foo/bar'    
  end

  it "should not append the app_root path if the path is absolute and contains .." do
    File.stub!(:read).and_return('{"enyoRoot": "/foo/bar/../baz" }')
    config = ErisConfig.new(:config_path => @config_path, :app_root => @app_root)
    config.enyo_root.should == '/foo/bar/../baz'    
  end
end