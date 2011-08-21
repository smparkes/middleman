#!/usr/bin/env gem build
# encoding: utf-8

require File.expand_path("../../middleman-core/lib/middleman-core/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-rendering"
  s.version     = Middleman::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.authors     = ["Thomas Reynolds"]
  s.email       = ["me@tdreyno.com"]
  s.homepage    = "http://middlemanapp.com"
  s.summary     = "Dynamic tempaltes for Middleman"
  s.description = "Dynamic tempaltes for Middleman"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("middleman-core", Middleman::VERSION)
  s.add_dependency("padrino-core", ["0.10.0"])
  s.add_dependency("tilt", ["~> 1.3.1"])
  s.add_dependency("maruku", ["~> 0.6.0"])
  s.add_dependency("slim", ["~> 1.0.1"])
  s.add_dependency("haml", ["~> 3.1.0"])
  s.add_dependency("sass", ["~> 3.1.7"])
  s.add_dependency("compass", ["~> 0.11.3"])
  s.add_dependency("coffee-script", ["~> 2.2.0"])
end

