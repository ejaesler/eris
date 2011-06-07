require 'thor'

module Eris
  class Tasks < Thor
    method_option :port, :default => "9999", :aliases => "-p", :desc => "which port you want server run on"

    desc "server", "Launch the Eris server for your Enyo app"

    def server
      puts "Starting Eris on port #{options["port"]}"
      exec("rackup -p #{options["port"]} #{@@source_root}/lib/eris/eris.ru")
    end
  end
end