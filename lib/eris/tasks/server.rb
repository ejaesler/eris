require 'thor'

module Eris
  class Tasks < Thor

    desc "server", "Launch the Eris server for your Enyo app"

    def server
      exec("rackup -p 9999 #{@@source_root}/lib/eris/eris.ru")
    end
  end
end