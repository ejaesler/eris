require 'spec_helper'

describe Eris, "`server`" do
  before :each do
    @server_pid = fork do
      @thor = Thor.new
      sample_app_dir = File.join(File.dirname(__FILE__), '..', '..', '..', 'fixtures', 'sample_app/')
      Dir.chdir sample_app_dir do
        @thor.invoke Eris::Tasks, "server"
      end
    end
    sleep 2
  end

  it "should start the Eris server on the default port" do
    `curl -s http://localhost:9999/`.should match("<html>")
  end

  after :each do
    Process.kill 9, @server_pid
  end
end