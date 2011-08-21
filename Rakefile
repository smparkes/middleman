require 'rubygems' unless defined?(Gem)
require 'rake/clean'
require 'rake/contrib/sshpublisher'
require 'fileutils' unless defined?(FileUtils)

require File.expand_path("../middleman-core/lib/middleman-core/version.rb", __FILE__)

include FileUtils

ROOT        = File.expand_path(File.dirname(__FILE__))
GEM_NAME    = 'middleman'

middleman_gems = [
  "middleman-core",
  "middleman-helpers",
  "middleman-rendering",
  "middleman-livereload",
  "middleman"
]

GEM_PATHS = middleman_gems.freeze

def rake_command(command)
  sh "#{Gem.ruby} -S rake #{command}", :verbose => true
end

%w(install gemspec package).each do |name|
  desc "Run #{name} for all projects"
  task name do
    GEM_PATHS.each do |dir|
      Dir.chdir(dir) { rake_command(name) }
    end
  end
end

desc "Clean pkg and other stuff"
task :clean do
  GEM_PATHS.each do |dir|
    Dir.chdir(dir) do
      %w(tmp pkg coverage).each { |dir| FileUtils.rm_rf dir }
    end
  end
  Dir["**/*.gem"].each { |gem| FileUtils.rm_rf gem }
end

desc "Clean pkg and other stuff"
task :uninstall do
  sh "gem search --no-version middleman | grep middleman | xargs gem uninstall -a"
end

desc "Displays the current version"
task :version do
  puts "Current version: #{Middleman::VERSION}"
end

desc "Executes a fresh install removing all middleman version and then reinstall all gems"
task :fresh => [:uninstall, :install, :clean]

desc "Pushes repository to GitHub"
task :push do
  puts "Pushing to github..."
  sh "git tag #{Middleman::VERSION}"
  sh "git push origin master"
  sh "git push origin #{Middleman::VERSION}"
end

desc "Release all middleman gems"
task :publish => :push do
  puts "Pushing to rubygems..."
  GEM_PATHS.each do |dir|
    Dir.chdir(dir) { rake_command("release") }
  end
  Rake::Task["clean"].invoke
end

desc "Run tests for all middleman gems"
task :test do
  sh "cd middleman-core && #{Gem.ruby} -S rake test", :verbose => true
end