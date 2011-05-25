Dir[File.dirname(__FILE__) + "/eris/**/*.rb"].each do |file|
  require file[0..-4]
end

require 'thor'

module Eris
  class Tasks < Thor
    @@source_root = File.join(File.dirname(__FILE__), '..')
  end
end