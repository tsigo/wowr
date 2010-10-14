$:.unshift(File.expand_path('../../../lib', __FILE__))

# PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..', '..')).freeze
# LIB_PATH = File.join(PROJECT_ROOT, 'lib').freeze
#
# ENV['RUBYLIB'] = LIB_PATH

require 'rspec/expectations'
require 'fakeweb'

FakeWeb.allow_net_connect = false

require 'wowr'

module FileFixtures
  def file_fixture(*args)
    File.read(File.expand_path("../file_fixtures/#{File.join(args)}", __FILE__))
  end
end

World(FileFixtures)
