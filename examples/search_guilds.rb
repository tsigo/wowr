$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false)
guilds = api.search_guilds('Juggernaut')
puts guilds[0..5].to_yaml
