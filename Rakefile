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

# bundle exec rcov -Ilib -t test/**/*.rb --exclude gems/ -o coverage_test
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

namespace :whitespace do
  FIND_FILE_BLACKLIST = "find . -type f | grep -v -e '.git/' -e 'coverage/' -e 'pkg/' -e 'vendor/' -e '.data' -e '.DS_Store'"

  desc 'Runs all whitespace tasks'
  task :all do
    Rake::Task["whitespace:remove_trailing"].invoke
    Rake::Task["whitespace:covert_to_soft_tabs"].invoke
    Rake::Task["whitespace:remove_blank_lines"].invoke
  end

  desc 'Removes trailing whitespace'
  task :remove_trailing do
    system %{
      echo Removing trailing whitespace
      for f  in `#{FIND_FILE_BLACKLIST}`;
        do cat $f | sed 's/[ \t]*$//' > .whitespace; cp .whitespace $f; rm .whitespace; echo $f;
      done
    }
  end

  desc 'Converts hard-tabs into two-space soft-tabs'
  task :covert_to_soft_tabs do
    system %{
      echo Converting hard-tabs into two-space soft-tabs
      for f in `#{FIND_FILE_BLACKLIST}`;
        do cat $f | sed 's/\t/  /g' > .soft_tabs; cp .soft_tabs $f; rm .soft_tabs; echo $f;
      done
    }
  end

  desc 'Remove consecutive blank lines'
  task :remove_blank_lines do
    system %{
      echo Removing consecutive blank lines
      for f in `#{FIND_FILE_BLACKLIST}`;
        do cat $f | sed '/./,/^$/!d' > .blank_lines; cp .blank_lines $f; rm .blank_lines; echo $f;
      done
    }
  end
end
