require 'thor'

module Eris
  class Tasks < Thor
    desc "generate", "generate an enyo application"
    def generate
      template "lib/eris/templates/Gemfile",'Gemfile'
      template "lib/eris/templates/Rakefile",'Rakefile'
      template "lib/eris/templates/jasmine.yml", "spec/unit/support/jasmine.yml"
      template "lib/eris/templates/jasmine_runner.rb.erb", "spec/unit/support/jasmine_runner.rb"
      template "lib/eris/templates/sampleSpec.js", "spec/unit/source/sampleSpec.js"
      create_file ".rvmrc", "rvm use ruby-1.9.2-p180@palm"
    end
  end
end