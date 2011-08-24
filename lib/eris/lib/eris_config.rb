require 'json'
require 'pathname'
require 'uri'

class ErisConfig   
  def initialize(opts)
    @config_hash = JSON.parse(File.read(opts[:config_path]))
    @app_root = opts[:app_root]
  end
  
  def enyo_root_for_environment
    ENV['IS_CI_BOX'] == "true" ? File.join(@config_hash['ciEnyoRoot'], 'enyo') : File.join(@config_hash['localEnyoRoot'], 'enyo')
  end
  
  def enyo_root
    if Pathname.new(enyo_root_for_environment).absolute?
      enyo_root_for_environment
    else
      File.join(@app_root, enyo_root_for_environment)
    end
  end

  def enyo_version
    @config_hash['enyoVersion'] || "0.10"
  end

  def enyo_js_path
    "usr/palm/frameworks/enyo/#{enyo_version}/framework/enyo.js"
  end

  def frameworks_root_for_environment
    ENV['IS_CI_BOX'] == "true" ? "usr/palm/frameworks/" : @config_hash['localFrameworksRoot'] || "usr/palm/frameworks"
  end

  def frameworks_root
    if Pathname.new(frameworks_root_for_environment).absolute?
      frameworks_root_for_environment
    else
      File.join(@app_root, frameworks_root_for_environment)
    end
  end

  def use_mojoloader
    @config_hash['useMojoLoader']
  end
end