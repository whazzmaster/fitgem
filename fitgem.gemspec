# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
$:.push File.join(File.dirname(__FILE__), '.', 'lib')

Gem::Specification.new do |s|
  s.name        = "fitgem"
  s.version     = "0.3.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zachery Moneypenny"]
  s.email       = ["fitgem@whazzmaster.com"]
  s.homepage    = "http://github.com/whazzmaster/fitgem"
  s.summary     = %q{OAuth client library to the data on fitbit.com}
  s.description = %q{A client library to send and retrieve workout/weight data from fitbit.com}

  s.rubyforge_project = "fitgem"
  s.add_dependency "oauth"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rb-fsevent"
  s.add_development_dependency "growl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
