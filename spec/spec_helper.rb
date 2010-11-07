$:.unshift(File.expand_path('../../lib', __FILE__))

require 'rubygems'
require 'rspec'
require 'wowr'

require 'fakeweb'
FakeWeb.allow_net_connect = false

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
  config.include(FileFixtures)
end
