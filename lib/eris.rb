excluded_files = [
    "/eris/lib/jasmine_config_overrides.rb",
    "/eris/lib/jasmine_rspec_runner.rb"
  ].map { |file| File.dirname(__FILE__) + file }

Dir[File.dirname(__FILE__) + "/eris/**/*.rb"].each do |file|
  require file[0..-4] unless excluded_files.include?(file)
end

require 'thor'
require 'curb'
require 'pathname'

module Eris
  class Tasks < Thor
    include Thor::Actions
    @@source_root = File.join(File.dirname(__FILE__), '..')
    source_root File.join(File.dirname(__FILE__), '..')
  end
end

Eris::FILE_PATH = File.expand_path(File.dirname(__FILE__))