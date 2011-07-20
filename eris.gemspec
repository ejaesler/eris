# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require File.dirname(__FILE__) + "/lib/eris/version"

Gem::Specification.new do |s|
  s.name        = "eris"
  s.version     = Eris::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["HP webOS", "Pivotal Labs"]
  s.email       = ["pair@pivotallabs.com"]
  s.homepage    = ""
  s.summary     = %q{Eris is a gem to help test driving webOS Enyo application development}
  s.description = %q{}

  s.rubyforge_project = "eris"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rack"
  s.add_dependency "json"
  s.add_dependency "sinatra"
  s.add_dependency "erubis"
  s.add_dependency "thor"
  s.add_dependency "curb"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "fuubar"
  s.add_development_dependency "nokogiri"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "rake"
end
