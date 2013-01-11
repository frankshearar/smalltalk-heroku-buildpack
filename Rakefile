require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test) do |test|
  test.pattern = 'test/*_test.rb'
  test.verbose = true
end

task :default => :test
