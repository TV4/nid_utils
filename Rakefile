require 'rake/clean'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

Bundler::GemHelper.install_tasks

CLEAN.add('coverage') 
CLEAN.add('spec/reports')
CLEAN.add('pkg')

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec)

desc "setup for continuous integration"
task 'ci:setup' => ["ci:setup:rspec"] do
  ENV["COVERAGE"] = "on"
end

#task that are run by continuous integration.
desc "Run rspec with code coverage"
task 'ci:spec' => ["ci:setup", "spec"]

task :default => :spec
