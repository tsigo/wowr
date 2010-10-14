$:.unshift(File.expand_path('../../../lib', __FILE__))

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
