require 'json'
require 'pathname'

class ErisConfig   
  def initialize(opts)
    @config_hash = JSON.parse(File.read(opts[:config_path]))
    @app_root = opts[:app_root]
  end
  
  def enyo_root_for_environment
    ENV['IS_CI_BOX'] == "true" ? @config_hash['ciEnyoRoot'] : @config_hash['localEnyoRoot']
  end
  
  def enyo_root
    if Pathname.new(enyo_root_for_environment).absolute?
      enyo_root_for_environment
    else
      File.join(@app_root, enyo_root_for_environment)
    end
  end
end