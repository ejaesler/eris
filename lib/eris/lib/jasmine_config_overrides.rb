require 'eris/lib/eris_config'

module Jasmine
  class Config
    def src_files
      if simple_config['src_files']
        p  match_files(src_dir, simple_config['src_files']) + ["usr/palm/frameworks/enyo/0.10/framework/enyo.js"]
        match_files(src_dir, simple_config['src_files']) + ["usr/palm/frameworks/enyo/0.10/framework/enyo.js"]
      else
        []
      end
    end
    
    def simple_config_file
      File.join(project_root, 'spec/unit/support/jasmine.yml')
    end
  end
end

module Jasmine
  def self.app(config)
    Rack::Builder.app do
      use Rack::Head
 
      map('/run.html')         { run Jasmine::Redirect.new('/') }
      map('/__suite__')        { run Jasmine::FocusedSuite.new(config) }
 
      map('/__JASMINE_ROOT__') { run Rack::File.new(Jasmine.root) }
      map(config.spec_path)    { run Rack::File.new(config.spec_dir) }
      map(config.root_path)    { run Rack::File.new(config.project_root) }
      eris_config = ErisConfig.new(:config_path => 'eris_config.json', :app_root => config.project_root)

      map("/usr/palm/frameworks") { run Rack::File.new(eris_config.enyo_root) }
 
      map('/') do
        run Rack::Cascade.new([
          Rack::URLMap.new('/' => Rack::File.new(config.src_dir)),
          Jasmine::RunAdapter.new(config)
        ])
      end
    end
  end
end