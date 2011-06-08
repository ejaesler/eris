require 'spec_helper'

describe Eris, "`server`" do

  describe "(with defaults)" do
    before :each do
      @server_pid = fork do
        sample_app_dir = File.join(File.dirname(__FILE__), '..', '..', '..', 'fixtures', 'sample_app/')
        Dir.chdir sample_app_dir do
          exec("eris server")
        end
      end
      sleep 2
    end

    it "should start the Eris server on the default port" do
      `curl -s http://localhost:9999/`.should match("<html>")
    end
  end

  describe "(with optional port)" do
    let :port do
      '6578'
    end

    before :each do
      @server_pid = fork do
        sample_app_dir = File.join(File.dirname(__FILE__), '..', '..', '..', 'fixtures', 'sample_app/')
        Dir.chdir sample_app_dir do
          exec("eris server --port=#{port}")
        end
      end
      sleep 2
    end

    it "should start the Eris server on the requested port" do
      `curl -s http://localhost:#{port}/`.should match("<html>")
    end
  end

  after :each do
    Process.kill 9, @server_pid
  end
end