require 'bundler/setup'

require 'rack/test'
require 'nokogiri'
require 'uri'

require 'eris'

#tmp_dir = "#{Dir.tmpdir}/eris"
#FileUtils.rm_rf tmp_dir
#FileUtils.mkdir_p tmp_dir
#Dir.chdir(tmp_dir)

#def app
#  Eris::Server.new("/tmp")
#end