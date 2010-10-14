$:.unshift(File.expand_path('../../lib', __FILE__))

require 'rubygems'
require 'rspec'
require 'wowr'

require 'fakeweb'
FakeWeb.allow_net_connect = false

module FileFixtures
  def file_fixture(*args)
    File.read(File.expand_path("../file_fixtures/#{File.join(args)}", __FILE__))
  end
end

RSpec.configure do |config|
  config.include(FileFixtures)
end
