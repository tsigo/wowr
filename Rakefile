require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake/testtask'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

$LOAD_PATH.unshift('lib')

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb"
end

desc "Generate aggregate code coverage"
task :coverage do
  rm_f "coverage"
  rm_f "coverage.data"
  Rake::Task["coverage:rspec"].invoke
  Rake::Task["coverage:cucumber"].invoke
end

namespace :coverage do
  desc "Generate code coverage for RSpec tests"
  RSpec::Core::RakeTask.new(:rspec) do |t|
    t.pattern = "./spec/**/*_spec.rb"
    t.rcov = true
    t.rcov_opts = %w{--exclude gems\/,spec\/,features\/ --sort coverage --aggregate coverage.data --text-report}
  end

  desc "Generate code coverage for Cucmber tests"
  Cucumber::Rake::Task.new(:cucumber) do |t|
    t.rcov = true
    t.rcov_opts = %w{--exclude gems\/,spec\/,features\/ --sort coverage --aggregate coverage.data}
  end
end

# TODO: remove Rake::TestTask :test once tests have been converted and functionality has been confirmed with Specs
# bundle exec rcov -Ilib -t test/**/*.rb --exclude gems/ -o coverage_test
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
