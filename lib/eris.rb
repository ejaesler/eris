Dir[File.dirname(__FILE__) + "/eris/**/*.rb"].each do |file|
  require file[0..-4]
end

require 'thor'
require 'curb'

module Eris
  class Tasks < Thor
    include Thor::Actions
    @@source_root = File.join(File.dirname(__FILE__), '..')
    source_root File.join(File.dirname(__FILE__), '..')
  end
end