$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false)
arena_teams = api.search_arena_teams("Lemon")
puts arena_teams.to_yaml
