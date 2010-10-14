$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false)
begin
  invalid_guild = api.get_guild('moo', :realm => 'bar')
rescue Wowr::Exceptions::GuildNotFound => e
  puts e.message
end
