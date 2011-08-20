# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
$:.push File.join(File.dirname(__FILE__), '.', 'lib')

require 'lib/fitgem/version'

Gem::Specification.new do |s|
  s.name        = "fitgem"
  s.version     = Fitgem::VERSION
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

  s.files         = [
    '.gitignore',
    '.rvmrc',
    'Gemfile'
    'Guardfile',
    'LICENSE',
    'README.md',
    'Rakefile',
    'fitgem.gemspec',
    'lib/fitgem.rb',
    'lib/fitgem/activities.rb',
    'lib/fitgem/body_measurements.rb',
    'lib/fitgem/client.rb',
    'lib/fitgem/devices.rb',
    'lib/fitgem/errors.rb',
    'lib/fitgem/foods.rb',
    'lib/fitgem/friends.rb',
    'lib/fitgem/helpers.rb',
    'lib/fitgem/notifications.rb',
    'lib/fitgem/sleep.rb',
    'lib/fitgem/time_range.rb',
    'lib/fitgem/units.rb',
    'lib/fitgem/users.rb',
    'lib/fitgem/water.rb',
    'spec/fitgem_spec.rb',
    'spec/spec_helper.rb'
  ]
  s.test_files   = [
    'spec/fitgem_spec.rb',
    'spec/spec_helper.rb'
  ]
  s.require_paths = ["lib"]
end
