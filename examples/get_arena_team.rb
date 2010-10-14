$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false)
arena_team = api.get_arena_team("E P I X", 5, :realm => "Mal'Ganis")
puts arena_team.to_yaml
