# -*- encoding: utf-8 -*-
require File.expand_path("../../middleman-core/lib/middleman-core/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman"
  s.version     = Middleman::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.authors     = ["Thomas Reynolds"]
  s.email       = ["me@tdreyno.com"]
  s.homepage    = "http://middlemanapp.com"
  s.summary     = "Hand-crafted frontend development"
  s.description = "A static site generator based on Sinatra. Providing dozens of templating languages (Haml, Sass, Compass, Slim, CoffeeScript, and more). Makes minification, compression, cache busting, Yaml data (and more) an easy part of your development cycle."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {fixtures,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # TODO remove for 2.1.x
  s.post_install_message =<<eos
********************************************************************************

  Welcome to Middleman 2.0
  
  In addition to many new features, some backwards-incompatible
  changes have been made to the structure of Middleman sites.
  
  Before running you old, v1.x project on Middleman 2.0,
  review the Migration guide:
  
  http://middlemanapp.com/guides/migrating

********************************************************************************
eos

  s.add_dependency("middleman-core",       Middleman::VERSION)
  s.add_dependency("middleman-rendering",  Middleman::VERSION)
  s.add_dependency("middleman-helpers",    Middleman::VERSION)
  s.add_dependency("middleman-livereload", Middleman::VERSION)
end