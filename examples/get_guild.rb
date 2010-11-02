$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false)
guild = api.get_guild('Juggernaut', :realm => "Mal'Ganis")

puts guild.to_yaml
