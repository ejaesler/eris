require 'bundler/setup'

require 'rack/test'
require 'nokogiri'
require 'uri'

require 'vcr'
require 'rspec'

require 'eris'

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.stub_with :webmock
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

#tmp_dir = "#{Dir.tmpdir}/eris"
#FileUtils.rm_rf tmp_dir
#FileUtils.mkdir_p tmp_dir
#Dir.chdir(tmp_dir)

#def app
#  Eris::Server.new("/tmp")
#end

def capture_output
   output = StringIO.new
   $stdout = output
   yield
   output.string
 ensure
   $stdout = STDOUT
end

def system!(command)
  system(command) || raise("Failed: #{command}")
end