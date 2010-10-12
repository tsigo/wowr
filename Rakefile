require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake/testtask'
require 'rspec/core/rake_task'

$LOAD_PATH.unshift('lib')

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb"
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.pattern = "./spec/**/*_spec.rb"
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec/,gems/', '--sort', 'coverage', '--text-report']
end

desc "Run tests"
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end
