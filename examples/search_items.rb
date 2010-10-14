$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false)
items = api.search_items('Cake')
puts items[0..5].to_yaml
