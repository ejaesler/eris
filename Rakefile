require 'bundler'
Bundler::GemHelper.install_tasks

namespace :jasmine do
  task :server do
    require 'jasmine'

    puts "your tests are here:"
    puts "  http://localhost:8888/"

    c = Jasmine::Config.new
    puts c.src_dir
    puts c.src_files
    c.start_server
  end

  desc "Run continuous integration tests"
  task :ci do
    require 'jasmine'
    require "rspec"
    require "rspec/core/rake_task"
    require 'eris'
    ENV['JASMINE_BROWSER'] = 'chrome'

    RSpec::Core::RakeTask.new(:jasmine_continuous_integration_runner) do |t|
      t.rspec_opts = ["--color", "--format", "progress"]
      t.verbose = true
    end
    Rake::Task["jasmine_continuous_integration_runner"].invoke
  end
end

desc "Run specs with local config"
task :jasmine => ['jasmine:server']