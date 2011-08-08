require 'thor'

module Eris
  class Tasks < Thor
    desc "generate", "generate an enyo application"
    def generate
      #template "lib/eris/templates/Gemfile",'Gemfile'
      #template "lib/eris/templates/Rakefile",'Rakefile'
      #template "lib/eris/templates/jasmine.yml", "spec/unit/support/jasmine.yml"
      #template "lib/eris/templates/sampleSpec.js", "spec/unit/source/sampleSpec.js"
      directory "lib/eris/templates/sample_app", "."
      create_file ".rvmrc", "rvm use ruby-1.9.2-p180@palm"
      #template "lib/eris/templates/ci_build.sh", "ci_build.sh"
      chmod "ci_build.sh", 0755
      #template "lib/eris/templates/eris_config.json", "eris_config.json"
      empty_directory "spec/unit/source/mock"
      empty_directory "spec/helpers/testResponses"
      #template "lib/eris/templates/specHelper.js", "spec/unit/specHelper.js"
    end
  end
end