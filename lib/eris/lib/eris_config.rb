require 'json'

class ErisConfig   
  def initialize(opts)
    @config_hash = JSON.parse(File.read(opts[:config_path]))
    @app_root = opts[:app_root]
  end
  
  def enyo_root
    if Pathname.new(@config_hash['enyoRoot']).absolute?
      @config_hash['enyoRoot']
    else
      File.join(@app_root, @config_hash['enyoRoot'])
    end
  end
end