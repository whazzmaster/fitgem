# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
$:.push File.join(File.dirname(__FILE__), '.', 'lib')

require 'fitbit'

Gem::Specification.new do |s|
  s.name        = "fitbit"
  s.version     = Fitbit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zachery Moneypenny"]
  s.email       = ["fitbit-gem@whazzmaster.com"]
  s.homepage    = "http://github.com/whazzmaster/fitbit"
  s.summary     = %q{OAuth client library to the data on Fitbit.com}
  s.description = %q{A client library to send and retrieve workout/weight data from Fitbit.com}

  s.rubyforge_project = "fitbit"
  
  s.add_dependency "oauth"
  
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
