#!/usr/bin/env gem build
# encoding: utf-8

require File.expand_path("../../middleman-core/lib/middleman-core/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-helpers"
  s.version     = Middleman::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.authors     = ["Thomas Reynolds"]
  s.email       = ["me@tdreyno.com"]
  s.homepage    = "http://middlemanapp.com"
  s.summary     = "View helpers for Middleman"
  s.description = "View helpers for Middleman"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("middleman-core", Middleman::VERSION)
  s.add_dependency("padrino-helpers", ["0.10.0"])
end

