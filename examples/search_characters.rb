$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false)
characters = api.search_characters(:search => 'Sebudai')
puts characters[0..5].to_yaml
