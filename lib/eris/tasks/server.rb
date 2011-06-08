require 'thor'

module Eris
  class Tasks < Thor
    desc "server", "Launch the Eris server for your Enyo app"
    method_option :port, :default => "9999", :aliases => "-p", :desc => "server port"

    def server
      port = options[:port]
      puts "Starting Eris on port #{port}"
      exec("rackup -p #{port} #{@@source_root}/lib/eris/eris.ru")
    end
  end
end