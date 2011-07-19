require 'spec_helper'

describe Eris do
  it "sets a constant of the base file path" do
    Eris::FILE_PATH.should == File.expand_path(File.dirname(__FILE__) + '/../../../../lib/')
  end
end