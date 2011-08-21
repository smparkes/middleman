# -*- encoding: utf-8 -*-
require File.expand_path("../../middleman-core/lib/middleman-core/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-livereload"
  s.version     = Middleman::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Thomas Reynolds"]
  s.email       = ["me@tdreyno.com"]
  s.homepage    = "https://github.com/tdreyno/middleman-livereload"
  s.summary     = %q{Adds LiveReload to Middleman}
  s.description = %q{Adds LiveReload to Middleman}

  s.rubyforge_project = "middleman-livereload"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  
  s.add_dependency("middleman-core", Middleman::VERSION)
  s.add_dependency("guard-livereload", ["~> 0.3.0"])
end
