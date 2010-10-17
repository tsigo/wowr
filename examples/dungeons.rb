$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false, :debug => true)
dungeons = api.get_dungeons()
puts dungeons.to_yaml
