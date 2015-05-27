# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
$:.push File.join(File.dirname(__FILE__), '.', 'lib')

require 'fitgem/version'

Gem::Specification.new do |s|
  s.name        = 'fitgem'
  s.version     = Fitgem::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Zachery Moneypenny']
  s.email       = ['fitgem@whazzmaster.com']
  s.homepage    = 'http://github.com/whazzmaster/fitgem'
  s.summary     = %q{OAuth client library to the data on fitbit.com}
  s.description = %q{A client library to send and retrieve workout, weight, and diet data from fitbit.com}

  s.rubyforge_project = 'fitgem'

  s.add_dependency 'oauth'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec',     '~> 3.0.0'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rdiscount'

  s.files = %w(LICENSE README.md fitgem.gemspec) + `git ls-files -z`.split("\x0").select { |f| f.start_with?("lib/") }
  s.require_paths = ['lib']
end
